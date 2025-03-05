{pkgs, ...}: {
  home.packages = with pkgs;
    [
      neofetch
      # Fonts
      noto-fonts
      font-awesome
      material-icons
      powerline-fonts
      dejavu_fonts
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.monoid
      nerd-fonts.zed-mono
      jq
      # System utils
      fzf
      htop
      btop
      # Haskell
      stack
    ]
    ++ (
      if !pkgs.stdenv.isDarwin
      then [
        # Fonts
        emojione
        # Multimedia
        vlc
        # Browser
        firefox
        # Desktop
        #slack
        # Screenshots
        imv
      ]
      else []
    );
}
