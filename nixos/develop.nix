{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    btop
    gnumake
    awscli
    elixir
    erlang
    jsonnet
    nodejs-18_x
    bun
    python3
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.virtualenv
    sbt
    scala
    rustup
    gcc
  ];

  programs.java = with pkgs; {
    enable = true;
    package = zulu;
  };
}
