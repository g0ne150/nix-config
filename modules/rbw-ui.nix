{ pkgs, ... }: {
  home.packages = with pkgs; [ dotool rofi-rbw-wayland ];
}
