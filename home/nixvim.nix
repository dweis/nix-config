{
  pkgs,
  nixvim-flake,
  ...
}: {
  home.packages = with pkgs; [
    nixvim-flake.packages.${system}.default
  ];

  programs.zsh.shellAliases = {
    vim = "nvim";
	  vi = "nvim";
  };
}
