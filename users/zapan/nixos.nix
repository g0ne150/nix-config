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
      "video"  # Required for GPU access (Steam, games, video acceleration)
      "render" # Required for GPU rendering (Steam, games, hardware acceleration)
    ]; # wheel group for Enable 'sudo' for the user.
  };

  imports = [
    ../../secrets
    ../../modules/base.nix
    ../../modules/dev-base.nix
    ../../modules/gui-base.nix
    ../../modules/niri.nix
    ../../modules/podman.nix
    ../../modules/steam.nix
    ../../modules/ydotool.nix
  ];
}
