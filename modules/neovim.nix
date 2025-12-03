{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins;
      [

        (nvim-treesitter.withPlugins (plugins:
          with plugins; [
            bash
            bibtex
            c
            cmake
            css
            diff
            dockerfile
            dtd
            git_config
            git_rebase
            gitattributes
            gitcommit
            gitignore
            go
            gomod
            gosum
            gowork
            graphql
            html
            http
            java
            javascript
            jsdoc
            json
            json5
            jsonc
            kotlin
            latex
            lua
            luadoc
            luap
            markdown
            markdown_inline
            ninja
            nix
            printf
            python
            query
            regex
            ron
            rst
            rust
            scala
            sql
            toml
            tsx
            typescript
            vim
            vimdoc
            vue
            xml
            yaml
          ]))
      ];
  };
}
