{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];
    terminal = "tmux-256color";
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm-kitty:RGB"
    '';
  };
}
