{
  pkgs,
  nixvim,
  ...
}: {
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    vscode-extensions.vadimcn.vscode-lldb
  ];

  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;

    # neovim options
    options = {
      termguicolors = true;
      relativenumber = false;
      number = true;
      wrap = false;
      showmode = true;
      smartcase = true;
      smartindent = true;
      incsearch = true;
      hlsearch = true;
      softtabstop = 2;
      shiftwidth = 2;
      history = 1000;
      colorcolumn = "80,100";
      list = true;
      listchars = "trail:.";
      completeopt = "menuone,menu,longest";
      cmdheight = 1;
    };

    # mappings
    maps = {
      normal = {
        "<Leader>t" = ":Telescope find_files<CR>";
      };
      visual = {
        ">" = ">gv";
        "<" = "<gv";
      };
    };

    # ...plugins...
    plugins = {
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      luasnip.enable = true;
      lightline.enable = true;
      lsp-format.enable = true;
      nix.enable = true;
      nvim-cmp = {
        enable = true;
        snippet.expand = "luasnip";
        sources = [
          {name = "path";}
          {name = "nvim_lsp";}
          {name = "luasnip";}
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select= true })";
        };
        #mapping = {
        #  "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        #  "<C-f>" = "cmp.mapping.scroll_docs(4)";
        #  "<C-Space>" = "cmp.mapping.complete()";
        #  "<C-e>" = "cmp.mapping.abort()";
        #  "<CR>" = "cmp.mapping.confirm({ select = true })";
        #};
      };
      nvim-tree.enable = true;
      telescope.enable = true;
      rust-tools.enable = true;
      treesitter.enable = true;

      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            K = "hover";
          };
        };
        servers = {
          rust-analyzer.enable = true;
          metals.enable = true;
          bashls.enable = true;
          clangd.enable = true;
          nil_ls.enable = true;
        };
      };

      #      dap = {
      #        enable = true;
      #        adapters = {
      #          executables = {
      #          };
      #          servers = {
      #          };
      #        };
      #        configurations = {
      #          rust = {
      #            name = "Rust debug";
      #            type = "codelldb";
      #            request = "launch";
      #            program = ''
      #              function()
      #                return vim.fn.input('Path to executable: '; vim.fn.getcwd() .. '/target/debug/'; 'file')
      #              end;
      #            '';
      #            cwd = "$\{workspaceFolder}";
      #            stopOnEntry = true;
      #            showDisassembly = "never";
      #          };
      #        };
      #      };
    };

    # ... and even highlights and autocommands !
    highlight.ExtraWhitespace.bg = "red";
    match.ExtraWhitespace = "\\s\\+$";
    autoCmd = [
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal tabstop=2 shiftwidth=2";
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
