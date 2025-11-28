#!/usr/bin/env bash
set -euo pipefail

# init.sh
# Usage: ./init.sh <disk-device> [swap-size] [root-size]
# Example: ./init.sh /dev/sda 32G 500G
#          ./init.sh /dev/nvme0n1 16G 1T
#          ./init.sh /dev/sda 0    # 不创建 swap 分区，根分区使用剩余所有空间
#          ./init.sh /dev/sda 32G  # 不指定根分区大小，使用剩余所有空间

DISK="${1:-}"
SWAP_SIZE="${2:-32G}" # default swap size: 32G
ROOT_SIZE="${3:-}"    # root partition size (optional)

if [[ -z "$DISK" ]]; then
    echo "Usage: $0 <disk-device> [swap-size] [root-size]"
    echo "Examples:"
    echo "  $0 /dev/sda 32G 500G    # 创建 32G swap 和 500G 根分区"
    echo "  $0 /dev/nvme0n1 16G 1T  # 创建 16G swap 和 1T 根分区"
    echo "  $0 /dev/sda 0           # 不创建 swap，根分区使用剩余所有空间"
    echo "  $0 /dev/sda 32G         # 创建 32G swap，根分区使用剩余所有空间"
    exit 1
fi

# 验证根分区大小格式（如果指定）
if [[ -n "$ROOT_SIZE" ]]; then
    if ! [[ "$ROOT_SIZE" =~ ^[0-9]+[TGMK]?$ ]]; then
        echo "Error: Invalid root partition size format: $ROOT_SIZE"
        echo "Valid formats: 1T, 500G, 512M, 1024 (in MB)"
        exit 1
    fi
fi

# Detect partition suffix: NVMe and MMC need "p"
detect_suffix() {
    local disk="$1"
    if [[ "$disk" =~ nvme || "$disk" =~ mmcblk ]]; then
        echo "p"
    else
        echo ""
    fi
}

# 磁盘类型检测函数
detect_disk_type() {
    local disk="$1"
    local block_name=$(basename "$disk")
    local rotational_file="/sys/block/${block_name}/queue/rotational"

    # 检查是否为 NVMe
    if [[ "$disk" =~ nvme ]]; then
        echo "nvme"
        return
    fi

    # 检查旋转属性（0=SSD, 1=HDD）
    if [[ -f "$rotational_file" ]]; then
        local rotational=$(cat "$rotational_file")
        if [[ "$rotational" == "0" ]]; then
            echo "ssd"
        else
            echo "hdd"
        fi
    else
        echo "unknown" # 无法确定，使用保守配置
    fi
}

# 检查是否需要创建 swap 分区
should_create_swap() {
    local swap_size="$1"
    # 如果 swap_size 为 0、0G、0M 等，则不创建 swap
    if [[ "$swap_size" =~ ^0[GMK]?$ ]]; then
        return 1 # false
    else
        return 0 # true
    fi
}

# 优化的 Btrfs 挂载选项函数
get_btrfs_opts() {
    local disk_type="$1"

    local base_opts="noatime,space_cache=v2,autodefrag"

    case "$disk_type" in
    nvme)
        echo "${base_opts},discard=async,compress=zstd:1,commit=15"
        echo "检测到 NVMe SSD，使用高性能配置（轻度压缩 zstd:1）" >&2
        ;;
    ssd)
        echo "${base_opts},discard=async,ssd,compress=zstd:1,commit=30"
        echo "检测到 SSD，使用平衡配置（轻度压缩 zstd:1）" >&2
        ;;
    hdd)
        echo "${base_opts},compress=zstd:3,commit=60"
        echo "检测到 HDD，使用存储优化配置（中等压缩 zstd:3）" >&2
        ;;
    *)
        echo "${base_opts},compress=zstd:2,commit=45"
        echo "无法确定磁盘类型，使用通用配置（中等压缩 zstd:2）" >&2
        ;;
    esac
}

echo "=== Checking UEFI mode ==="
if [[ ! -d /sys/firmware/efi ]]; then
    echo "Error: System is not booted in UEFI mode."
    exit 1
fi
echo "OK: UEFI detected."

echo "=== Checking disk existence: $DISK ==="
if ! lsblk -nd "$DISK" >/dev/null 2>&1; then
    echo "Error: Disk $DISK not found."
    exit 1
fi
lsblk "$DISK"

read -rp "WARNING: This will erase ALL data on $DISK. Type 'yes' to continue: " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
    echo "Cancelled."
    exit 0
fi

PSUF=$(detect_suffix "$DISK")
EFI_PART="${DISK}${PSUF}1"

echo "=== Wiping existing filesystem signatures ==="
wipefs -a "$DISK" || true
sgdisk -Z "$DISK" || true

echo "=== Creating new GPT partition table ==="
sgdisk -og "$DISK"

echo "=== Creating partitions ==="

# EFI 分区
sgdisk -n 1:0:+300M -t 1:ef00 -c 1:"EFI System Partition" "$DISK"

# Swap 分区（如果不需要则不创建）
if should_create_swap "$SWAP_SIZE"; then
    echo "- 创建 Swap 分区: ${SWAP_SIZE}"
    sgdisk -n 2:0:+${SWAP_SIZE} -t 2:8200 -c 2:"Linux Swap" "$DISK"
    SWAP_PART="${DISK}${PSUF}2"
    BTRFS_PART="${DISK}${PSUF}3"
else
    echo "- 跳过 Swap 分区创建 (参数: $SWAP_SIZE)"
    SWAP_PART=""
    BTRFS_PART="${DISK}${PSUF}2"
fi

# Btrfs 根分区
if [[ -n "$ROOT_SIZE" ]]; then
    echo "- 创建 Btrfs 根分区: ${ROOT_SIZE}"
    sgdisk -n "${BTRFS_PART##*${PSUF}}":0:+${ROOT_SIZE} -t "${BTRFS_PART##*${PSUF}}":8300 -c "${BTRFS_PART##*${PSUF}}":"Btrfs Root" "$DISK"
else
    echo "- 创建 Btrfs 根分区: 使用剩余所有空间"
    sgdisk -n "${BTRFS_PART##*${PSUF}}":0:0 -t "${BTRFS_PART##*${PSUF}}":8300 -c "${BTRFS_PART##*${PSUF}}":"Btrfs Root" "$DISK"
fi

echo "=== Refreshing partition table ==="
partprobe "$DISK"
sleep 1
lsblk "$DISK"

echo "=== Formatting partitions ==="
echo "- EFI -> FAT32: $EFI_PART"
mkfs.fat -F32 -n EFI "$EFI_PART"

# 格式化 Swap 分区（如果需要）
if [[ -n "$SWAP_PART" ]]; then
    echo "- Swap: $SWAP_PART"
    mkswap -L SWAP "$SWAP_PART"
else
    echo "- 跳过 Swap 分区格式化"
fi

echo "- Btrfs: $BTRFS_PART"
mkfs.btrfs -f -L NIXOS_BTRFS "$BTRFS_PART"

echo "=== Creating Btrfs subvolumes ==="
TMP_MNT="/mnt/.btrfs_tmp"
mkdir -p "$TMP_MNT"
mount "$BTRFS_PART" "$TMP_MNT"

# 检测磁盘类型并获取优化的挂载选项
echo "=== 检测磁盘类型并优化 Btrfs 配置 ==="
DISK_TYPE=$(detect_disk_type "$DISK")
mount_opts=$(get_btrfs_opts "$DISK_TYPE")
echo "使用的 Btrfs 挂载选项: $mount_opts"

# Subvolume structure
SUBROOT="@"
SUBHOME="@home"
SUBNIX="@nix"
SUBVAR="@var"
SUBSNAPSHOTS="@snapshots"
SUBLOG="@log"
SUBCACHE="@cache"
SUBTMP="@tmp"

# Create subvolumes
echo "- 创建根文件系统子卷: $SUBROOT"
btrfs subvolume create "$TMP_MNT/$SUBROOT"

echo "- 创建用户主目录子卷: $SUBHOME"
btrfs subvolume create "$TMP_MNT/$SUBHOME"

echo "- 创建 Nix 包管理子卷: $SUBNIX"
btrfs subvolume create "$TMP_MNT/$SUBNIX"

echo "- 创建系统变量数据子卷: $SUBVAR"
btrfs subvolume create "$TMP_MNT/$SUBVAR"

echo "- 创建快照存储子卷: $SUBSNAPSHOTS"
btrfs subvolume create "$TMP_MNT/$SUBSNAPSHOTS"

echo "- 创建系统日志子卷: $SUBLOG"
btrfs subvolume create "$TMP_MNT/$SUBLOG"

echo "- 创建缓存数据子卷: $SUBCACHE"
btrfs subvolume create "$TMP_MNT/$SUBCACHE"

echo "- 创建临时文件子卷: $SUBTMP"
btrfs subvolume create "$TMP_MNT/$SUBTMP"

umount "$TMP_MNT"
rmdir "$TMP_MNT"

echo "=== Mounting Btrfs subvolumes ==="

mount -o "${mount_opts},subvol=${SUBROOT}" "$BTRFS_PART" /mnt

# Create directory structure
mkdir -p /mnt/{boot,home,nix,var,snapshots}

# Mount subvolumes
echo "- 挂载用户主目录: $SUBHOME"
mount -o "${mount_opts},subvol=${SUBHOME}" "$BTRFS_PART" /mnt/home

echo "- 挂载 Nix 包管理: $SUBNIX"
mount -o "${mount_opts},subvol=${SUBNIX}" "$BTRFS_PART" /mnt/nix

echo "- 挂载系统变量数据: $SUBVAR"
mount -o "${mount_opts},subvol=${SUBVAR}" "$BTRFS_PART" /mnt/var

echo "- 挂载快照存储: $SUBSNAPSHOTS"
mount -o "${mount_opts},subvol=${SUBSNAPSHOTS}" "$BTRFS_PART" /mnt/snapshots

# 创建 var 目录下的子目录结构
mkdir -p /mnt/var/{log,cache,tmp}

# 挂载日志子卷
echo "- 挂载系统日志: $SUBLOG"
mount -o "${mount_opts},subvol=${SUBLOG}" "$BTRFS_PART" /mnt/var/log

# 挂载缓存子卷
echo "- 挂载缓存数据: $SUBCACHE"
mount -o "${mount_opts},subvol=${SUBCACHE}" "$BTRFS_PART" /mnt/var/cache

# 挂载临时文件子卷
echo "- 挂载临时文件: $SUBTMP"
mount -o "${mount_opts},subvol=${SUBTMP}" "$BTRFS_PART" /mnt/var/tmp

echo "=== Mounting EFI partition ==="
mount "$EFI_PART" /mnt/boot

# 启用 Swap 分区（如果需要）
echo "=== Enabling swap ==="
if [[ -n "$SWAP_PART" ]]; then
    swapon "$SWAP_PART"
    echo "- 已启用 Swap 分区: $SWAP_PART"
else
    echo "- 跳过 Swap 分区启用"
fi

echo "=== Preparing common directories ==="
# Create essential directories in var subvolume
mkdir -p /mnt/var/lib

echo "子卷结构说明:"
echo "  /mnt              -> @ (根文件系统)"
echo "  /mnt/home         -> @home (用户数据)"
echo "  /mnt/nix          -> @nix (Nix 包管理)"
echo "  /mnt/var          -> @var (系统变量数据)"
echo "  /mnt/snapshots    -> @snapshots (快照存储)"
echo "  /mnt/var/log      -> @log (系统日志)"
echo "  /mnt/var/cache    -> @cache (缓存数据)"
echo "  /mnt/var/tmp      -> @tmp (临时文件)"
echo "  /mnt/var/lib      -> @var/lib (系统库文件)"

echo
echo "=== Disk setup complete ==="
lsblk -o NAME,SIZE,FSTYPE,LABEL,UUID,MOUNTPOINT "$DISK"

echo
echo "Current mounts:"
mount | grep "/mnt" || true

echo
echo "Next steps:"
echo "  nixos-generate-config --root /mnt"
echo "  Edit configuration.nix or place your flake"
echo "  Run nixos-install"
