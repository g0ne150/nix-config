{ pkgs, ... }: {

  # Gnome display manager
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  programs.niri = {
    enable = true;
    useNautilus = true;
  };
  environment.pathsToLink = [ "share/thumbnailers" ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  services.gnome.sushi.enable = true;

  # For gnome software
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    kitty # Terminal
    nautilus # File manager
    pkgs.libheif
    pkgs.libheif.out
    pkgs.xdg-utils
    fuzzel
    mako
    xwayland-satellite
  ];

  programs.waybar.enable = true; # top bar

  # For IME not working on Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
