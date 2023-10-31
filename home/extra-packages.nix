{ pkgs, ... }: {
  home.packages = with pkgs; [
    neofetch
    # Browser
    firefox
    # Dekstop
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
    # Screenshots
    imv
  ];
}
