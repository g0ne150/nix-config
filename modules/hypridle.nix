{ pkgs, ... }: {
  services.hypridle = let
    lock = "${pkgs.hyprlock}/bin/hyprlock";
    # lock = "${pkgs.systemd}/bin/loginctl lock-session";

    brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";

    display = status:
      "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in {
    enable = true;
    settings = {
      general = {
        # avoid starting multiple hyprlock instances.
        lock_cmd = "pidof ${lock} || ${lock}";
        # lock before suspend.
        before_sleep_cmd = lock;
        # to avoid having to press a key twice to turn on the display.
        after_sleep_cmd = display "on";
      };

      listener = [
        {
          timeout = 300; # 5min.
          on-timeout =
            "${brightnessctl} -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "${brightnessctl} -r"; # monitor backlight restore.
        }

        # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
        # listener { 
        #     timeout = 150                                          # 2.5min.
        #     on-timeout = brightnessctl -sd rgb:kbd_backlight set 0 # turn off keyboard backlight.
        #     on-resume = brightnessctl -rd rgb:kbd_backlight        # turn on keyboard backlight.
        # }

        {
          timeout = 600; # 10min
          on-timeout = lock; # lock screen when timeout has passed
        }

        {
          timeout = 630; # 10.5min
          # screen off when timeout has passed
          on-timeout = display "off";
          # screen on when activity is detected after timeout has fired.
          on-resume = display "on";
        }

        {
          timeout = 1800; # 30min
          on-timeout = "${pkgs.systemd}/bin/systemctl suspend"; # suspend pc
        }
      ];

    };
  };
}
