{ ... }:
{
  imports = [
    # ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "clawdbot";

  services.openssh.enable = true;

  system.stateVersion = "25.11";
}
