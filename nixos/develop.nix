{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    awscli
    elixir
    erlang
    jsonnet
    nodejs-18_x
    python3
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.virtualenv
    sbt
    scala
    rustup
  ];

  programs.java = with pkgs; {
    enable = true;
    package = zulu;
  };
}
