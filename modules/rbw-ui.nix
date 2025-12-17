{ pkgs, ... }: {
  # ensure ./ydotool.nix is imported by nix, not home-manager
  home.packages = with pkgs; [ rofi-rbw-wayland ];
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "https://vaultwarden.zapan.club:10";
      email = "g0ne150@hotmail.com";
      pinentry = pkgs.pinentry-gnome3;
    };
  };
}
