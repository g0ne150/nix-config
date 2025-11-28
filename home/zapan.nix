{ config, pkgs, ... }: {
  home = {
    username = "zapan";
    homeDirectory = "/home/zapan";
  };

  programs.git = {
    enable = true;
    userName = "Zapan Gao";
    userEmail = "g0ne150@hotmail.com";
  };
  programs.bash = { enable = true; };

  home.stateVersion = "25.05";
}
