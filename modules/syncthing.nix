{ ... }:
{
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        zapan-club = {
          name = "zapan-club";
          id = "OEEPJAW-3OW4QSI-PVDFTSS-WKM2VWF-R64TSB5-CYF6O6A-T5ZSV7O-2D2KDQF";
          addresses = [ "quic://zapan.club:22000" ];
        };
      };
    };
  };
}
