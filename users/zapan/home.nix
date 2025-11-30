{ config, pkgs, ... }: 
{
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
        file_manager = "${pkgs.nautilus}/bin/nautilus";
      };
    };
  };

  xdg.configFile = let
    dotfiles = "${config.home.homeDirectory}/nix-dotfiles/dot_config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    configs = {
      niri = "niri";
      waybar = "waybar";
      qutebrowser = "qutebrowser";
    };
  in builtins.mapAttrs (name:
    subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    }) configs;

  home.stateVersion = "25.05";
}
