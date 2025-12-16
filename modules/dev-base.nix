{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # java
    jdk
    maven

    # nodejs
    nodejs

    lua

    go

    rustc
    cargo
  ];
}
