# Zapan's nix configuration repo

## 常用命令

1. `nixos-install --flake .#hostname` 初次安装系统
1. `nixos-rebuild switch --flake .#hostname` 应用配置文件
1. `nix flake update` 更新 flake.lock
1. `nix search xx` 搜索 nix pkgs
1. `nix develop` 按照当前目录下 flake.nix 准备一个 shell 环境
1. `nix repl .#` 加载当前 flake 进入 repl
  - `nixosConfigurations.zenbook.config` config 变量
  - `nixosConfigurations.zenbook.config.home-manager.users.zapan` home-manager 变量。


### 清理

1. `nix profile history --profile /nix/var/nix/profiles/system`
   - 查看当前可用的所有历史版本
1. `sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system`
   - 清理 7 天之前的所有历史版本
1. `sudo nix-collect-garbage --d/--delete-old`
   - root 运行，删除所有未使用的包
1. `nix-collect-garbage -d/--delete-old`
   - 用户运行，删除 home-manager 的历史版本和包

## 参考文档

1. [NixOS 官方 Wiki](https://wiki.nixos.org/wiki/NixOS_Wiki)
1. [NixOS 社区 Wiki](https://nixos.wiki/wiki/Main_Page) DeepSeek 推荐用这个
1. [Package、NixOS options 搜索](https://search.nixos.org/options?channel=25.11)
1. [Home manager options search](https://home-manager-options.extranix.com/?query=&release=release-25.11)
1. [Nix api 参考文档](https://noogle.dev/)
1. [thiscute.world nixos and flake 中文文档](https://nixos-and-flakes.thiscute.world/zh/introduction/)
