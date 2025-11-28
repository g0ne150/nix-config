{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ../../../modules/base.nix
    ../../../modules/gui-base.nix

    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-vm"; # Define your hostname.
  networking.networkmanager.enable = true;


  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).

  system.stateVersion = "25.05"; # Did you read the comment?

}
