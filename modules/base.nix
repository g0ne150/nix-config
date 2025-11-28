{ pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
  };

  users.users.zapan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # wheel group for Enable ‘sudo’ for the user.
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "zh_CN.UTF-8" ];
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    curl
    lm_sensors
  ];
}
