{ pkgs, lib, ... }:
{

  environment.systemPackages = with pkgs; [
    firefox
    brightnessctl
    polkit_gnome
    seahorse
    bitwarden-desktop
    qutebrowser
    statix
    mpv
    jellyfin-mpv-shim
    # wechat
    (wechat.overrideAttrs (oldAttrs: {
      src = pkgs.fetchurl {
        url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
        hash = "sha256-XxAvFnlljqurGPDgRr+DnuCKbdVvgXBPh02DLHY3Oz8=";
      };
    }))
    # xorg.xprop
    xprop
    gnome-font-viewer
    telegram-desktop
    libreoffice-fresh
    wpsoffice-cn
    drawio
  ];

  services.hardware.bolt.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service

  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    # jack.enable = true;
  };

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      nerd-fonts.jetbrains-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.comic-shanns-mono

      lxgw-wenkai
    ];

    enableDefaultPackages = true;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      # waylandFrontend = true;
      addons = with pkgs; [ fcitx5-rime ];
    };
  };

  qt = {
    enable = true;
    style = "adwaita-dark";
  };

  programs.dconf.enable = true;
}
