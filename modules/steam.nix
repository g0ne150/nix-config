{ pkgs, ... }: {

  # 参考: https://yalter.github.io/niri/Xwayland.html#proton-ge-native-wayland
  # 1. Linux Wayland 下基于 proton 兼容模式运行 Windows 游戏，添加运行参数: PROTON_ENABLE_WAYLAND=1 %command%
  # 2. Steam 主界面黑屏的问题，可以通过设置-界面-禁用GPU加速解决

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}
