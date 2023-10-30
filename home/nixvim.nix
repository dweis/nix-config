{
  pkgs,
  nixvim,
  ...
}: {
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    vimAlias = true;
    viAlias = true;

    # neovim options
    options = {
      relativenumber = true;
      incsearch = true;
    };

    extraConfigVim = ''
      set number
      set nowrap
      set showmode
      set smartcase
      set smartindent
      set softtabstop=2
      set shiftwidth=2
      set history=1000
      set colorcolumn=80,100
      set list listchars=trail:.
      set completeopt=menuone,menu,longest
      set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox,output,node_modules,bower_components
      set wildmode=longest,list,full

      set t_Co=256

      set cmdheight=1
    '';

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
      telescope.enable = true;
      nvim-tree.enable = true;
      lightline.enable = true;
      rust-tools.enable = true;
      nix.enable = true;

      lsp = {
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
          #          bashls.enable = true;
          #          clangd.enable = true;
          #          nil_ls.enable = true;
        };
      };
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
      #vim-nix
    ];
  };
}
