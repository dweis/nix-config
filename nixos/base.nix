{
  config,
  pkgs,
  options,
  ...
}: {
  imports = [
    ./develop.nix
    ./ledger-nano-s.nix
    ./users.nix
    ./printscan.nix
    ./firewall.nix
  ];

  nixpkgs.config = {
    # Allow non-free
    allowUnfree = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "us";

  environment.systemPackages = with pkgs; [
    ntfs3g
    ntfsprogs
    inotify-tools
    imagemagick7
    file
    killall
    curl
    wget
    git
    pciutils
    unzip
    usbutils
    zip
  ];

  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
  };

  services.openssh.enable = true;

  hardware.ledger-nano-s.enable = true;

  system.autoUpgrade.enable = false;

  networking.timeServers = options.networking.timeServers.default ++ ["ca.pool.ntp.org"];
}
