{
  config,
  pkgs,
  lib,
  nixpkgs,
  ...
}: let
  #flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  #hyprland = (import flake-compat {
  #  src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
  #}).defaultNix;
  config = {
    name = "Derrick Weis";
    email = "derrick@derrickweis.com";
    githubUsername = "dweis";
    color = {
      # Dracula - https://github.com/dracula/dracula-theme
      background = "#282a36";
      currentLine = "#44475a";
      selection = "#44475a";
      foreground = "#f8f8f2";
      comment = "#6272a4";
      cyan = "#8be9fd";
      green = "#50fa7b";
      orange = "#ffb86c";
      pink = "#ff79c6";
      purple = "#bd93f9";
      red = "#ff5555";
      yellow = "#f1fa8c";
      # extra
      darkGray = "#040404";
      white = "#bfbfbf";
      black = "#000000";
      blue = "#caa9fa";
      brightRed = "#ff6e67";
      brightGreen = "#5af78e";
      brightYellow = "#f4f99d";
      brightBlue = "#caa9fa";
      brightMagenta = "#ff92d0";
      brightCyan = "#9aedfe";
      brightWhite = "#e6e6e6";
    };
    fontSize = 12;
    monospaceFont = "Hack";
    uiFont = "Noto Sans";
  };
in
  with config; {
    imports = [
      ./hyprland
    ];

    # imports = [
    #   hyprland.homeManagerModules.default
    # ];
    # wayland.windowManager.hyprland = {
    #  enable = true;
    /*
    xwayland.enable = true;
    #plugins = with plugins; [ hyperbars borderapp ];
    plugins = [
      #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];

    extraConfig = ''
      $mod = SUPER
      bind = $mod, Return, exec, alacritty
      bind = $mod, r, exec, hyprctl restart
      bind = $mod, Escape, exec, hyprctl dispatch exit
      bind = $mod, p, exec, bemenu-run

      xwayland {
       force_zero_scaling = true
      }

      monitor=eDP-1,2560x1440@60,0x0,2

      general {
        gaps_in = 3
        gaps_out = 3
        border_size=1
        no_border_on_floating = true
        layout = dwindle
        resize_on_border = true
      }

      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        mouse_move_enables_dpms = true
        enable_swallow = true
      }

      dwindle {
        no_gaps_when_only = false
        pseudotile = true
        preserve_split = true
      }


      env = GDK_SCALE,2
      env = XCURSOR_SIZE,32
      env = GDK_DPI_SCALE,0.5
      env = WINIT_HIDPI_FACTOR,2.0

      exec-once = waybar

      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      ${builtins.concatStringsSep "\n" (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in ''
            bind = $mod, ${ws}, workspace, ${toString (x + 1)}
            bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
          ''
        )
        10)}
    '';
    */
    #  };

    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };

    home.stateVersion = "23.05"; # Please read the comment before changing.
    home.username = "derrick";
    home.homeDirectory = "/home/derrick";

    fonts.fontconfig.enable = true;

    home = {
      packages = with pkgs; [
        # Browser
        firefox
        # Dekstop
        xautolock
        i3lock-fancy
        slack
        spotify
        vlc
        # Fonts
        noto-fonts
        font-awesome
        material-icons
        powerline-fonts
        dejavu_fonts
        emojione
        # System utils
        fzf
        htop
        # Haskell
        stack
        # Waybar
        waybar
      ];

      file.".stack/config.yaml".text = ''
        templates:
          params:
            author-name: ${name}
            author-email: ${email}
            github-username: ${githubUsername}
            copyright: 'Copyright: (c) 2019 Derrick Weis'
        nix:
          enable: true
          packages: [zlib]
        system-ghc: true
      '';

      file.".ghci".text = ''
        :set editor ~/.nix-profile/bin/vi
      '';

      file.".haskeline".text = ''
        editMode: Vi
      '';

      file.".inputrc".text = ''
        set editing-mode vi
        set keymap vi
      '';

      file.".face".source = ./face.png;

      file.".config/rofi/dracula.rasi".text = ''
        // Dracula colors
        * {
            background: ${color.background};
            current-line: ${color.currentLine};
            selection: ${color.selection};
            foreground: ${color.foreground};
            comment: ${color.comment};
            cyan: ${color.cyan};
            green: ${color.green};
            orange: ${color.orange};
            pink: ${color.pink};
            purple: ${color.purple};
            red: ${color.red};
            yellow: ${color.yellow};
        }
        * {
            selected-normal-background:     @cyan;
            normal-background:              @background;
            normal-foreground:              @foreground;
            alternate-normal-background:    @normal-background;
            alternate-normal-foreground:    @foreground;
            selected-normal-foreground:     @normal-background;
            urgent-foreground:              @red;
            urgent-background:              @normal-background;
            alternate-urgent-background:    @urgent-background;
            alternate-urgent-foreground:    @urgent-foreground;
            selected-active-foreground:     @foreground;
            selected-urgent-background:     @normal-background;
            alternate-active-background:    @normal-background;
            alternate-active-foreground:    @selected-active-foreground;
            alternate-active-background:    @selected-active-background;
            border-color:                   @selected-normal-background;
            separatorcolor:                 @border-color;
            spacing: 2;
            background-color: @normal-background;
        }
        #window {
            border:           3;
            padding:          9;
        }
        #mainbox {
            background-color: inherit;
            border:  0;
            padding: 5;
        }
        #textbox {
            text-color: @foreground;
        }
        #element {
            border:  0;
            padding: 1px ;
        }
        #element.normal.normal {
            background-color: @normal-background;
            text-color:       @normal-foreground;
        }
        #element.normal.urgent {
            background-color: @urgent-background;
            text-color:       @urgent-foreground;
        }
        #element.normal.active {
            background-color: @active-background;
            text-color:       @active-foreground;
        }
        #element.selected.normal {
            background-color: @selected-normal-background;
            text-color:       @selected-normal-foreground;
        }
        #element.selected.urgent {
            background-color: @selected-urgent-background;
            text-color:       @selected-urgent-foreground;
        }
        #element.selected.active {
            background-color: @selected-active-background;
            text-color:       @selected-active-foreground;
        }
        #element.alternate.normal {
            background-color: @alternate-normal-background;
            text-color:       @alternate-normal-foreground;
        }
        #element.alternate.urgent {
            background-color: @alternate-urgent-background;
            text-color:       @alternate-urgent-foreground;
        }
        #element.alternate.active {
            background-color: @alternate-active-background;
            text-color:       @alternate-active-foreground;
        }
        #scrollbar {
            border:       0;
        }
        #button.selected {
            background-color: @selected-normal-background;
            text-color:       @selected-normal-foreground;
        }
        #inputbar {
            spacing:    10;
            text-color: @normal-foreground;
            background-color: inherit;
            padding:    1px ;
        }
        #case-indicator {
            spacing:    0;
            text-color: @normal-background;
        }
        #entry {
            spacing:    0;
            text-color: @normal-foreground;
        }
        #prompt {
            spacing:    0;
            text-color: @normal-foreground;
        }
      '';
    };

    programs = {
      home-manager.enable = true;

      alacritty = {
        enable = false;
        settings = {
          window = {
            dimensions = {
              columns = 80;
              lines = 24;
            };
          };
          font = {
            normal = {
              family = monospaceFont;
            };
            bold = {
              family = monospaceFont;
            };
            italic = {
              family = monospaceFont;
            };
            size = fontSize;
          };
          draw_bold_text_with_bright_colors = true;
          colors = {
            primary = {
              background = "${color.background}";
              foreground = "${color.foreground}";
            };
            normal = {
              black = "${color.black}";
              red = "${color.red}";
              green = "${color.green}";
              yellow = "${color.yellow}";
              blue = "${color.blue}";
              magenta = "${color.purple}";
              cyan = "${color.cyan}";
              white = "${color.white}";
            };
            bright = {
              black = "${color.background}";
              red = "${color.brightRed}";
              green = "${color.brightGreen}";
              yellow = "${color.brightYellow}";
              blue = "${color.brightBlue}";
              magenta = "${color.brightMagenta}";
              cyan = "${color.brightCyan}";
              white = "${color.brightWhite}";
            };
          };
          background_opacity = 0.87;
          visual_bell = {
            animation = "EaseOutExpo";
            duration = 0;
          };
          mouse_bindings = [
            {
              mouse = "Middle";
              action = "PasteSelection";
            }
          ];
          live_config_reload = true;
        };
      };

      direnv = {
        enable = true;
        enableZshIntegration = true;
      };

      git = {
        enable = true;
        userName = "${name}";
        userEmail = "${email}";
      };

      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        extraConfig = ''
          set number
          set nowrap
          set showmode
          set smartcase
          set smartindent
          set softtabstop=2
          set shiftwidth=2
          set expandtab
          set history=1000
          set colorcolumn=80,100
          set list listchars=trail:.

          set completeopt=menuone,menu,longest

          set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox,output,node_modules,bower_components
          set wildmode=longest,list,full

          set t_Co=256

          set cmdheight=1

          colorscheme dracula

          " -- Supertab
          let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

          if has("gui_running")
            imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
          else " no gui
            if has("unix")
              inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
            endif
          endif

          " -- NERDtree
          map <Leader>n :NERDTreeToggle<CR>

          " -- Ctrl-P
          map <silent> <Leader>t :CtrlP()<CR>
          noremap <leader>b<space> :CtrlPBuffer<cr>
          let g:ctrlp_custom_ignore = '\v[\/]dist$'

          " -- Airline
          let g:airline_powerline_fonts = 1

          " -- HIE
          let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper'] }
          let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']
          hi link ALEError Error
          hi Warning term=underline cterm=underline ctermfg=Yellow gui=undercurl guisp=Gold
          hi link ALEWarning Warning
          hi link ALEInfo SpellCap
          nnoremap <F5> :call LanguageClient_contextMenu()<CR>
          map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
          map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
          map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
          map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
          map <Leader>lb :call LanguageClient#textDocument_references()<CR>
          map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
          map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
        '';

        plugins = with pkgs.vimPlugins; [
          dracula-vim
          vim-plug
          sensible
          airline
          vim-nix
          syntastic
          ctrlp
          deoplete-nvim
          fzf-vim
          editorconfig-vim
          awesome-vim-colorschemes
          nerdcommenter
          nerdtree
          supertab
          vim-scala
          vim-plug
          LanguageClient-neovim
          vim-stylish-haskell
          hlint-refactor-vim
          haskell-vim
          vim-haskellConcealPlus
          deoplete-rust
        ];
      };

      rofi = {
        enable = true;
        terminal = "\${pkgs.alacritty}/bin/alacritty";
        theme = "dracula";
        font = "${monospaceFont} 16";
        extraConfig = {
          modi = "combi";
          drun-icon-theme = "Numix Square";
          show-icons = true;
        };
        #rofi.modi: combi
        #rofi.drun-icon-theme: Numix Square
        #rofi.show-icons: true
      };

      tmux = {
        enable = true;
        keyMode = "vi";
        terminal = "tmux-256color";
      };

      zsh = {
        enable = true;
        oh-my-zsh = {
          enable = true;
          theme = "norm";
          plugins = ["aws" "ssh-agent"];
        };
        envExtra = ''
          EDITOR="vim"
          TERM="xterm-256color"
        '';
        shellAliases = {
          fonts = "fc-list | cut -f2 -d: | sort -u";
          nix-search = "nix-env -qaP '*' | grep";
          nix-cleanup = "nix-collect-garbage -d && nix-store --optimize";
        };
      };
    };

    #  services.compton = {
    #    enable = true;
    #    backend = "glx";
    #    #blur = true;
    #    shadow = true;
    #    activeOpacity = "0.98";
    #    inactiveOpacity = "0.90";
    #    menuOpacity = "0.95";
    #    fade = true;
    #    extraOptions = ''
    #      paint-on-overlay = true;
    #      glx-no-stencil = true;
    #      glx-no-rebind-pixmap = true;
    #    '';
    #  };

    #  services.swayidle = {
    #      enable = true;
    #      systemdTarget = "graphical-session.target";
    #      # TODO: Make dynamic for window manager
    #      events = [
    #        {
    #          event = "before-sleep";
    #          command = "${pkgs.swaylock}/bin/swaylock -df";
    #        }
    #        {
    #          event = "after-resume";
    #          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
    #        }
    #        {
    #          event = "lock";
    #          command = "${pkgs.swaylock}/bin/swaylock -df";
    #        }
    #      ];
    #      timeouts = [
    #        {
    #          timeout = 900;
    #          command = "${pkgs.swaylock}/bin/swaylock -df";
    #        }
    #        {
    #          timeout = 1200;
    #          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
    #        }
    #      ];
    #    };

    services.dunst = with pkgs; {
      enable = true;
      iconTheme = {
        package = numix-icon-theme-square;
        name = "Numix-Square";
        size = "48";
      };
      settings = {
        global = {
          format = "<b>%s</b>\\n%b";
          geometry = "600x7-20+20";
          transparency = 20;
          frame_width = 3;
          frame_color = color.blue;
          font = "${uiFont} ${toString (fontSize * 0.75)}";
          follow = "keyboard";
          max_icon_size = 64;
          icon_position = "left";
          browser = "google-chrome-stable";
          demnu = "rofi -dmenu -p dunst:";
        };
        frame = {
        };
        urgency_low = {
          background = color.background;
          foreground = color.foreground;
          frame_color = color.foreground;
          timeout = 5;
        };
        urgency_normal = {
          background = color.background;
          foreground = color.cyan;
          frame_color = color.cyan;
          timeout = 5;
        };
        urgency_critical = {
          background = color.background;
          foreground = color.red;
          frame_color = color.red;
          timeout = 20;
        };
      };
    };

    #services.redshift = {
    #  enable = true;
    #  latitude = "44.389";
    #  longitude = "-79.690";
    #};
  }
