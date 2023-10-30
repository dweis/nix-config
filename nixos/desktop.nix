{ pkgs, specialArgs, ... }:

let
  wallpaper = pkgs.copyPathToStore ./wallpaper.jpg;
in
{
  nix.settings.trusted-users = [specialArgs.username];

  # needed for sway
  security.polkit.enable = true;
  sound.enable = true;
  sound.mediaKeys.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    google-chrome
    glxinfo
    #i3blocks-gaps
    networkmanagerapplet
    numix-icon-theme
    numix-icon-theme-square
    numix-cursor-theme
    numix-gtk-theme
    paprefs
    pavucontrol
    rofi
    scrot
    vscode
    xbindkeys
    xorg.xmodmap
  ];

#  services.xserver = {
#    enable = false;
#    layout = "us";
#    xkbOptions = "caps:super";
#    desktopManager = {
#      xterm.enable = false;
#    };
#    libinput = {
#      touchpad = {
#        naturalScrolling = true;
#      };
#    };
#  };

  services.upower.enable = true;
  systemd.services.upower.enable = true;

  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;
    fontDir.enable = true;

    fonts = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra

      source-sans
      source-serif 
      source-han-sans
      source-han-serif

      # nerdfonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
        ];
      })

      (pkgs.callPackage ../fonts/icomoon-feather-icon-font.nix {})
    ];

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  environment.extraInit = ''
      # GTK3 theme
      export GTK_THEME="Numix"
    '';

  environment.etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-icon-theme-name=Numix Square
        gtk-theme-name=Numix
        gtk-application-prefer-dark-theme = false
      '';
      mode = "444";
    };

    environment.etc."gtk-2.0/gtkrc" = {
      text = ''
        gtk-icon-theme-name=Numix Square
      '';
      mode = "444";
  };
}
