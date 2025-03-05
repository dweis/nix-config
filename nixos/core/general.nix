{
  lib,
  pkgs,
  options,
  ...
}: {
  imports = [
    ./users.nix
  ];


  # add user's shell into /etc/shells
  environment.shells = with pkgs; [
    bash
    zsh
  ];

  # set user's default shell system-wide
  users.defaultUserShell = pkgs.zsh;
  # for nix server, we do not need to keep too much generations
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
  # boot.loader.grub.configurationLimit = 10;
  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 1w";
  };

  nix.settings = {
    # Manual optimise storage: nix-store --optimise
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
    auto-optimise-store = true;
    builders-use-substitutes = true;
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };


  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = lib.mkDefault false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };
  # for power management
  services = {
    #power-profiles-daemon = {
    #  enable = true;
    #};
    upower.enable = true;
  };


  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };


  virtualisation.docker = {
    enable = true;
    # start dockerd on boot.
    # This is required for containers which are created with the `--restart=always` flag to work.
    enableOnBoot = true;
  };

  nixpkgs.config = {
    # Allow non-free
    allowUnfree = true;
  };

  console.keyMap = "us";

  environment.systemPackages = with pkgs; [
    curl
    inotify-tools
    imagemagick
    file
    git
    git-lfs
    #google-cloud-sdk
    killall
    ntfs3g
    ntfsprogs
    pciutils
    usbutils
    unzip
    wget
    zip
  ];

  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
  };

  system.autoUpgrade.enable = false;

  networking.timeServers = ["ca.pool.ntp.org"];
}
