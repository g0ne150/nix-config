{ pkgs, ... }: {

  # Gnome display manager
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  programs.niri.enable = true;

  # For gnome software
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    nautilus
    pkgs.libheif
    pkgs.libheif.out
    pkgs.xdg-utils
    fuzzel
    swaylock
    swayidle
    mako
    xwayland-satellite
    qutebrowser
  ];
  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = { };

  programs.waybar.enable = true; # top bar

  # For IME not working on Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.pathsToLink = [ "share/thumbnailers" ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

}
