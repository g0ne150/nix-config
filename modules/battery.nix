{...}: {
  powerManagement.enable = true;

  services.tlp = {
    enable = true;
    START_CHARGE_THRESH_BAT0 = 75; # 75 and below it starts to charge
    STOP_CHARGE_THRESH_BAT0 = 80;  # 80 and above it stops charging
  };
}
