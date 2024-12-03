# Depends on nixos hardware channel:
# $ sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
# $ sudo nix-channel --update nixos-hardware
{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos/core
    ../../nixos/develop.nix
    ../../nixos/kubernetes.nix
  ];

  networking.hostName = "lambda";

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Network Manager.
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  #services.colord.enable = true;
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
  ];

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "24.05"; # Did you read the comment?
}
