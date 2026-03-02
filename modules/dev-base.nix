{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # java
    jdk
    jdk8
    maven

    # nodejs
    nodejs
    pnpm

    bun

    lua

    go

    rustc
    cargo

    just
    gnumake

    sqlite
  ];
}
