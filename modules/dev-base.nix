{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # java
    jdk
    jdk8
    maven

    # nodejs
    nodejs

    lua

    go

    rustc
    cargo
  ];
}
