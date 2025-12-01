{ config, pkgs, home-manager, ... }: 
let 
  username = "zapan";
in
{
  home = {
    inherit username;
    homeDirectory = "/home/zapan";
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "Zapan Gao";
      email = "g0ne150@hotmail.com";
    };
  };
  programs.bash = { 
    enable = true;
    shellAliases = {
      proxy-on = "export {all,http,https}_proxy=http://127.0.0.1:1080;";
      proxy-off = "unset {all,http,https}_proxy";
    };
  };

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
      fcitx = "fcitx";
      fcitx5 = "fcitx5";
      qutebrowser = "qutebrowser";
      Throne = "Throne";
      mako = "mako";
    };
  in builtins.mapAttrs (name:
    subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    }) configs;

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

# Polkit gnome agent systemd user servcie
systemd.user.services.polkit-gnome-authentication-agent-1 = {
  Unit = {
    Description = "polkit-gnome-authentication-agent-1";
    Wants = [ "graphical-session.target" ];
    After = [ "graphical-session.target" ];
  };
  Install = {
    WantedBy = [ "graphical-session.target" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Restart = "on-failure";
    RestartSec = 1;
    TimeoutStopSec = 10;
  };
};

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  home.stateVersion = "25.05";
}
