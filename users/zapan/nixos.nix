{ ... }: {
  nix.settings = {
    trusted-users = [ "zapan" ];
  };

  users.users.zapan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "ydotool"
    ]; # wheel group for Enable ‘sudo’ for the user.
  };

  imports = [
    ../../modules/base.nix
    ../../modules/dev-base.nix
    ../../modules/gui-base.nix
    ../../modules/niri.nix
    ../../modules/podman.nix
    ../../modules/steam.nix
    ../../modules/ydotool.nix
  ];
}
