{ pkgs, lazyvim, ... }:
{

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  imports = [ lazyvim.homeManagerModules.default ];
  programs.lazyvim = {
    enable = true;
    configFiles = ./lazyvim-config;
    extraPackages = with pkgs; [
      nixd
      nixfmt
      # pyright
      # alejandra
      # black
      ripgrep
      fd
      tree-sitter
      luajitPackages.luarocks
      go
      gofumpt
      gotools
      prettier
      markdown-toc
      markdownlint-cli2
      shfmt
      sqlfluff
      stylua
      lua
    ];
    extras = {
      test.core.enable = true;
      coding.yanky.enable = true;
      editor = {
        inc-rename.enable = true;
        dial.enable = true;
      };
      util = {
        dot.enable = true;
        mini-hipatterns.enable = true;
        rest.enable = true;
      };
      lang = {

        git.enable = true;
        go.enable = true;
        json.enable = true;
        markdown.enable = true;
        nix.enable = true;
        java.enable = true;
        python.enable = true;
        rust.enable = true;
        sql.enable = true;
      };
    };
  };
}
