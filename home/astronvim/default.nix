{
  pkgs,
  astronvim,
  ...
}:
###############################################################################
#
#  AstroNvim's configuration and all its dependencies(lsp, formatter, etc.)
#
#e#############################################################################
{
  xdg.configFile = {
    # astronvim's config
    "nvim".source = astronvim;

    # my custom astronvim config, astronvim will load it after base config
    # https://github.com/AstroNvim/AstroNvim/blob/v3.32.0/lua/astronvim/bootstrap.lua#L15-L16
    "astronvim/lua/user".source = ./astronvim_user;
  };

  nixpkgs.config = {
    programs.npm.npmrc = ''
      prefix = ''${HOME}/.npm-global
    '';
  };

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;

      withPython3 = true;
      withNodeJs = true;
      extraPackages = with pkgs; [];
    };
  };
  home = {
    packages = with pkgs;
      [
        graphviz

        #-- c/c++
        cmake
        cmake-language-server
        gnumake
        checkmake
        gcc # c/c++ compiler, required by nvim-treesitter!
        llvmPackages.clang-unwrapped # c/c++ tools with clang-tools such as clangd
        lldb

        #-- python
        nodePackages.pyright # python language server
        python311Packages.black # python formatter
        python311Packages.ruff-lsp

        #-- rust
        rust-analyzer
        cargo # rust package manager
        rustc
        rustfmt

        #-- zig
        zls

        #-- nix
        nil
        rnix-lsp
        # nixd
        statix # Lints and suggestions for the nix programming language
        deadnix # Find and remove unused code in .nix source files
        alejandra # Nix Code Formatter

        #-- golang
        go
        gomodifytags
        iferr # generate error handling code for go
        impl # generate function implementation for go
        gotools # contains tools like: godoc, goimports, etc.
        gopls # go language server
        delve # go debugger

        #-- lua
        stylua
        lua-language-server

        #-- bash
        nodePackages.bash-language-server
        shellcheck
        shfmt

        #-- javascript/typescript --#
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages."@tailwindcss/language-server"

        #-- scala --#
        coursier
        metals

        #-- CloudNative
        nodePackages.dockerfile-language-server-nodejs
        terraform
        terraform-ls
        hadolint # Dockerfile linter

        #-- Others
        taplo # TOML language server / formatter / validator
        nodePackages.yaml-language-server
        sqlfluff # SQL linter
        actionlint # GitHub Actions linter
        buf # protoc plugin for linting and formatting
        proselint # English prose linter

        #-- Misc
        tree-sitter # common language parser/highlighter
        nodePackages.prettier # common code formatter
        marksman # language server for markdown
        glow # markdown previewer

        #-- Optional Requirements:
        gdu # disk usage analyzer, required by AstroNvim
        ripgrep # fast search tool, required by AstroNvim's '<leader>fw'(<leader> is space key)
        lazygit
      ]
      ++ (
        if pkgs.stdenv.isDarwin
        then []
        else [
          # Issues compiling on Darwin
          jsonnet
          jsonnet-language-server
          # HTML/CSS/JSON/ESLint language servers extracted from vscode
          nodePackages.vscode-langservers-extracted
          # Linux only
          gdb
          #-- verilog / systemverilog
          verible
        ]
      );
  };
}
