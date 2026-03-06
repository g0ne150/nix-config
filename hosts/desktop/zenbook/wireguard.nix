{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking.wireguard = {
    enable = false;
    interfaces = {
      wg0 = {
        ips = [ "10.1.0.2/32" ];

        # public key: F+CGMqKssC6v4lKHXF0cd36H1KkSptpX6nMwgyrMu1w=
        privateKeyFile = config.age.secrets.zenbook_wg_private_key.path;

        peers = [
          {
            name = "zapan.club-home";
            publicKey = "xboADhqL9MWMdKUvgjP6EitqSARhW4lnJ9Re/c2OXFE=";
            allowedIPs = [
              "10.0.0.0/8"
            ];
            endpoint = "zapan.club:51820";
          }
        ];
      };
    };
  };
}
