{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ../../../modules/battery.nix
    ../../../modules/intel-graphics.nix
    ./mount-opts.nix
    ./hardware-configuration.nix

    ../../../secrets
    ../../../modules/base.nix
    ../../../modules/dev-base.nix
    ../../../modules/gui-base.nix
    ../../../modules/niri.nix
    ../../../modules/podman.nix
    ../../../modules/steam.nix
    ../../../modules/ydotool.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    # systemd-boot.enable = true;
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
    };
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "zenbook"; # Define your hostname.

  nix.settings = {
    trusted-users = [ "zapan" ];
  };

  users.users.zapan = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # wheel group for Enable 'sudo' for the user.
      "networkmanager"
      "ydotool"
    ];
  };
  # services.openssh.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).

  system.stateVersion = "25.11"; # Did you read the comment?

}
