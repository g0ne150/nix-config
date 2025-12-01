{ pkgs, pkgs-unstable, lib, ... }: {

  environment.systemPackages = lib.mkMerge [
    (with pkgs; [ polkit_gnome bitwarden-desktop qutebrowser neovim mpv jellyfin-mpv-shim ])
    (with pkgs-unstable; [ throne ])
  ];

  services.hardware.bolt.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    package = pkgs-unstable.pipewire;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    # jack.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-extra
      noto-fonts-emoji

      nerd-fonts.jetbrains-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.comic-shanns-mono
    ];

    enableDefaultPackages = true;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
    ];
  };

  programs.dconf.enable = true;
}
