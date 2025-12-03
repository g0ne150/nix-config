{ pkgs, ... }: {

  environment = {
    systemPackages = with pkgs; [ podman-compose ];
    variables = { REGISTRY_AUTH_FILE = "$HOME/.config/containers/auth.json"; };
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.zapan.extraGroups = [ "podman" ];
}

