{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # java
    jdk
    jdk8
    maven

    # nodejs
    nodejs
    pnpm

    lua

    go

    rustc
    cargo
    rustup

    just
    gnumake
  ];
}
