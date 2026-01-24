{
  ...
}:
let
  # Btrfs 挂载选项优化
  #
  # NVMe SSD 特性：
  # 1. 速度快，但写放大问题会影响寿命
  # 2. 支持 TRIM/DISCARD，需要定期回收未使用的块
  # 3. 对于随机小文件访问，压缩可以提高性能（减少 I/O）
  #
  # Btrfs 特性：
  # 1. CoW（Copy-on-Write）机制，写入时会产生额外的写放大
  # 2. 支持透明压缩，减少写入量和空间占用
  # 3. 支持子卷、快照等高级功能
  # 4. 定期需要 scrub 和 balance 来维护文件系统健康

  # 主文件系统挂载选项
  # compress=zstd: 使用 zstd 算法压缩，在压缩率和性能间取得良好平衡
  #   - 减少写入量，延长 SSD 寿命
  #   - 读取时解压速度快，现代 CPU 几乎无开销
  #   - 对于文本、代码等数据压缩率很高，可以节省大量空间
  #
  # noatime: 不记录文件访问时间戳
  #   - 减少不必要的写操作（每次读文件都会产生写入）
  #   - 对 SSD 寿命有显著帮助
  #   - 大多数应用不需要访问时间信息
  #
  # discard=async: 异步 TRIM
  #   - SSD 需要定期 TRIM 来回收未使用的块
  #   - async 模式性能最好，在后台定期执行
  #   - 相比 periodic（fstrim）更实时，但不会阻塞 I/O
  #   - 比 discard=continuous 更高效（避免每个删除操作都触发 TRIM）
  #
  # ssd: 明确告诉 btrfs 使用 SSD 优化策略
  #   - 虽然 btrfs 可以自动检测，但明确指定更可靠
  #   - 启用 SSD 特定的分配器策略（减少碎片）
  #   - 调整提交超时等参数
  #
  # space_cache=v2: 使用 v2 空间缓存
  #   - 比 v1 更快、更可靠
  #   - 减少挂载时间
  #   - 现代版本默认使用 v2，但明确指定更安全
  mount_opts = [
    "compress=zstd:1"
    "noatime"
    "discard=async"
    "ssd"
    "space_cache=v2"
  ];
in
{

  fileSystems."/".options = mount_opts;

  # /home 用户数据
  # 使用相同的压缩策略，用户文件通常有良好的压缩率
  fileSystems."/home".options = mount_opts;

  # /nix Nix store
  # 压缩可能收益一般（因为 Nix store 文件去重效果好，但数据类型多样）
  # 但仍然可以节省空间，保持压缩
  fileSystems."/nix".options = mount_opts;

  # /var 系统可变数据
  # 系统变量，保持压缩
  fileSystems."/var".options = mount_opts;

  # /snapshots btrfs 快照
  # 快照主要是增量数据，压缩可以显著节省空间
  fileSystems."/snapshots".options = mount_opts;

  # /var/log 日志文件
  # 日志通常是文本文件，压缩率很高
  # 日志频繁写入，但压缩可以显著减少 I/O 量
  fileSystems."/var/log".options = mount_opts;

  # /var/cache 缓存目录
  # 缓存可能已经被压缩（如包管理器缓存），但压缩仍有价值
  # 临时文件频繁读写，可以考虑不压缩以提高性能
  # 但为了节省空间和减少写入，仍推荐压缩
  fileSystems."/var/cache".options = mount_opts;

  # /var/tmp 临时文件
  # 临时文件通常生命周期短，频繁读写
  # 可以考虑不压缩以提高性能，但考虑到：
  #   1. 减少写入量对 SSD 有益
  #   2. 大多数临时文件是可压缩的
  #   3. 临时文件通常不会太多
  # 仍推荐压缩
  fileSystems."/var/tmp".options = mount_opts;

  # 注意事项：
  #
  # 1. 压缩会消耗 CPU，但对于现代 CPU，开销很小
  #    - zstd 算法在压缩率和性能间取得良好平衡
  #    - 如果 CPU 性能受限，可以考虑使用 lzo（更快，但压缩率较低）
  #
  # 2. discard=async 需要内核 5.6+ 支持
  #    - NixOS 默认使用较新内核，应该支持
  #    - 如果不支持，可以回退到 discard=continuous 或使用定期 fstrim
  #
  # 3. 定期监控 btrfs 使用情况
  #    - 使用 `btrfs filesystem df /` 查看空间使用
  #    - 使用 `btrfs device usage /` 查看设备使用情况
  #    - 使用 `compsize /` 查看压缩率
  #
  # 4. 定期备份数据
  #    - 虽然 btrfs 有快照功能，但仍建议定期备份到其他设备
  #    - 可以使用 btrfs send/receive 或其他备份工具
  #
  # 5. SSD 寿命监控
  #    - 使用 `smartctl -a /dev/nvme0n1` 查看健康状态
  #    - 关注 Percentage Used 值（磨损指示器）
  #    - 关注意图 Media Errors 和 Available Spare
}
