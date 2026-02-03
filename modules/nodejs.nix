{ pkgs, ... }:
let
  pnpm_home = "$HOME/.local/share/pnpm";
in
{
  home.packages = with pkgs; [
    nodejs
    pnpm
  ];

  home.sessionPath = [
    pnpm_home
  ];

  home.sessionVariables = {
    PNPM_HOME = pnpm_home;
  };

}
