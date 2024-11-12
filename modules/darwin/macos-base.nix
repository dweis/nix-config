{pkgs, ...}: {
  programs.zsh.enable = true;

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      # nerdfonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
        ];
      })
    ];
  };
  
  system.stateVersion = 5;
}
