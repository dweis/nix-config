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
      ./alacritty.nix
      ./nixvim.nix
      ./tmux.nix
    ];

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


    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
      };

      git = {
        enable = true;
        userName = "${name}";
        userEmail = "${email}";
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
  }
