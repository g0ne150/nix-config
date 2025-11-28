# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a NixOS configuration repository for managing system configurations using the Nix package manager and flakes. The repository contains:

- **Flake-based configuration** (`flake.nix`) for reproducible system builds
- **Modular configuration** organized by hosts and modules
- **Home Manager** configuration for user-specific settings
- **Initialization scripts** for disk setup and system installation

## Common Development Commands

### Building and Testing

```bash
# Build the NixOS configuration for the VM host
nix build .#nixosConfigurations.nixos-vm

# Enter development shell with all dependencies
nix develop

# Apply configuration changes to running system
sudo nixos-rebuild switch --flake .#nixos-vm

# Test configuration without applying
sudo nixos-rebuild test --flake .#nixos-vm
```

### System Initialization

```bash
# Initialize disk partitions and filesystem (destructive operation)
./init.sh /dev/sda 32G 500G

# Generate hardware configuration after disk setup
nixos-generate-config --root /mnt

# Install NixOS with current configuration
nixos-install --flake .#nixos-vm
```

### Development Workflow

```bash
# Update flake inputs
nix flake update

# Show available outputs
nix flake show

# Build specific output
nix build .#homeConfigurations.zapan.activationPackage
```

## Architecture and Structure

### Configuration Hierarchy

- **`flake.nix`** - Main entry point defining all system configurations and inputs
- **`hosts/`** - Host-specific configurations
  - `desktop/nixos-vm/` - Virtual machine configuration
- **`modules/`** - Reusable configuration modules
  - `base.nix` - Core system settings (Nix, users, packages)
  - `gui-base.nix` - GUI-related settings (fonts, desktop environment)
- **`home/`** - Home Manager configurations
  - `zapan.nix` - User-specific settings and packages

### Key Components

1. **Nix Flakes** - Provides reproducible builds and dependency management
2. **Home Manager** - Manages user-level configuration and packages
3. **Modular Design** - Configuration split into reusable modules
4. **Btrfs Filesystem** - Uses subvolumes for system organization

### Configuration Flow

1. Flake imports host configurations from `hosts/`
2. Host configurations import modules from `modules/`
3. Modules provide specific functionality (base system, GUI, etc.)
4. Home Manager handles user-level configuration
5. Hardware-specific settings are auto-generated

## Important Notes

- Uses NixOS 25.05 channel for stability
- Configured for Chinese locale and timezone (Asia/Shanghai)
- Includes USTC mirror for faster package downloads in China
- Supports both UEFI boot and Btrfs filesystem with optimized subvolumes
- Disk initialization script (`init.sh`) provides automated partitioning with disk-type detection

## Development Guidelines

- Always test configurations with `nixos-rebuild test` before applying
- Use `nix flake update` regularly to keep dependencies current
- Hardware-specific configurations should be in `hardware-configuration.nix`
- User packages and settings belong in Home Manager configuration
- System-wide packages and settings belong in NixOS modules