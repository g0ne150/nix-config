{ pkgs, ... }: {
  home.packages = with pkgs; [ dotool rofi-rbw-wayland ];
  programs.rbw = {
    enable = true;
    settings = {
      base_url = "https://vaultwarden.zapan.club:10";
      email = "g0ne150@hotmail.com";
    };
  };
}
