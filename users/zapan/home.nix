{ config, pkgs, home-manager, ... }:
let username = "zapan";
in {
  home = {
    inherit username;
    homeDirectory = "/home/zapan";
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

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  # Polkit gnome agent systemd user servcie
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      Type = "simple";
      ExecStart =
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  xdg.configFile = let
    dotfiles =
      "${config.home.homeDirectory}/nix-config/nix-dotfiles/dot_config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    configs = {
      niri = "niri";
      waybar = "waybar";
      fcitx = "fcitx";
      fcitx5 = "fcitx5";
      qutebrowser = "qutebrowser";
      Throne = "Throne";
      mako = "mako";
      kitty = "kitty";
      fuzzel = "fuzzel";
    };
  in builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "Zapan Gao";
        email = "g0ne150@hotmail.com";
      };
    };

    bash = {
      enable = true;
      shellAliases = {
        proxy-on = "export {all,http,https}_proxy=http://127.0.0.1:1080;";
        proxy-off = "unset {all,http,https}_proxy";
      };
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  home.file.".local/share/fcitx5/rime/default.custom.yaml" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nix-config/nix-dotfiles/dot_local/share/fcitx5/rime/default.custom.yaml";
  };

  home.file.".m2/settings.xml" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nix-config/nix-dotfiles/dot_m2/settings.xml";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  imports = [
    ./ssh-config.nix
    ../../modules/hypridle.nix
    ../../modules/hyprlock.nix
    ../../modules/clipboard.nix
    # ../../modules/neovim.nix
    ../../modules/rbw-ui.nix
    ../../modules/cursor.nix
    ../../modules/default-apps.nix
    ../../modules/claude-code.nix
  ];

  home.stateVersion = "25.11";
}
