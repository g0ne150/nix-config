{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    polkit_gnome
    bitwarden-desktop
    qutebrowser
  ];

  services.hardware.bolt.enable = true;

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

  programs.dconf.enable = true;
}
