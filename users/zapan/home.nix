{ pkgs, ... }: {
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

  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # file_manager = "${pkgs.xdg-utils}/bin/xdg-open";
        file_manager = "${pkgs.gnome.nautilus}/bin/nautilus";
      };
    };
  };

  home.stateVersion = "25.05";
}
