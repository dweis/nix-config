{ pkgs, ... }:

{
  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    yubikey-personalization
    yubikey-personalization-gui
  ];

  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];
}
