{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ../../../users/zapan/nixos.nix

    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "zenbook"; # Define your hostname.

  services.openssh.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).

  system.stateVersion = "25.05"; # Did you read the comment?

}
