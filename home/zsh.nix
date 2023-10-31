{pkgs, ...}: {
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
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
}
