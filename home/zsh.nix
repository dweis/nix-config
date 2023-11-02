{pkgs, ...}: {
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      #oh-my-zsh = {
      #  enable = true;
      #  theme = "norm";
      #  plugins = ["aws" "ssh-agent"];
      #};
      shellAliases = {
        fonts = "fc-list | cut -f2 -d: | sort -u";
        nix-search = "nix-env -qaP '*' | grep";
        nix-cleanup = "nix-collect-garbage -d && nix-store --optimize";
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      # https://starship.rs/config/#prompt
      settings = {
        aws = { disabled = true; };
        gcloud = { disabled = true; };
        git_status = {
          ahead = "⇡($count)";
          diverged = "⇕⇡($ahead_count)⇣($behind_count)";
          behind = "⇣($count)";
          modified = "!($count)";
          staged = "[++($count)](green)";
        };
      };
    };
  };
}
