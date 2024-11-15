# Depends on nixos hardware channel:
# $ sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
# $ sudo nix-channel --update nixos-hardware
{
  pkgs,
  lib,
  ...
}: {
  networking.hostName = "monoid";

  # Network Manager.
  networking.networkmanager.enable = true;

  imports = [
    ./hardware-configuration.nix
    ../../nixos/base.nix
    ../../nixos/laptop.nix
    ../../nixos/core-desktop.nix
    ../../nixos/core-server.nix
    ../../nixos/desktop.nix
    ../../nixos/hyprland.nix
    ../../nixos/kubernetes.nix
    ../../nixos/devices
  ];

  # Fix font sizes in X
  services.xserver.dpi = 108;

  # Fix sizes of GTK/GNOME ui elements
  environment.variables = {
    GDK_SCALE = lib.mkDefault "1.6";
    GDK_DPI_SCALE = lib.mkDefault "0.8";
    WINIT_HIDPI_FACTOR = "1.6";
    JAVA_OPTIONS = "-Dsun.java2d.uiScale=1.6";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth.enable = true;

  console.packages = with pkgs; [terminus_font];
  console.font = "ter-i32b";

  console.earlySetup = true;

  #services.colord.enable = true;
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    argyllcms
    blueman
  ];

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.bluetooth.enable = true;

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      {
        keys = [224];
        events = ["key"];
        command = "/run/current-system/sw/bin/light -U 5";
      }
      {
        keys = [225];
        events = ["key"];
        command = "/run/current-system/sw/bin/light -A 5";
      }
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "24.05"; # Did you read the comment?
}
