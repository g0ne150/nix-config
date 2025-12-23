{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # java
    javaPackages.compiler.openjdk21
    javaPackages.compiler.openjdk8
    maven

    # nodejs
    nodejs

    lua

    go

    rustc
    cargo
  ];
}
