{ pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
    trusted-users = [ "zapan" ];
  };

  users.users.zapan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # wheel group for Enable ‘sudo’ for the user.
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "zh_CN.UTF-8/UTF-8" ];
  };

  # replace by gnome keyring 
  # programs.ssh.startAgent = true;

  # do not need to keep too much generations
  boot.loader.systemd-boot.configurationLimit = 10;
  # boot.loader.grub.configurationLimit = 10;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Optimise storage
  # you can also optimise the store manually via:
  #    nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    home-manager
    wget
    git
    curl
    tree
    htop
    lm_sensors
    sysstat

    zip
    unzip
    xz
    zstd

    ripgrep
    fzf
    jq
    fd
    lazygit

    mtr
    iperf3
    dnsutils
    nmap

    libgcc
    gcc
    nodejs
    python314
    jdk
    lua
    go
    rustc
    cargo

    tlrc
  ];
}
