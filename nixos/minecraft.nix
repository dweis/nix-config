{ pkgs, ... }:

{
  networking.firewall.allowedUDPPorts = [
    4445 # upnotify
  ];


  environment.systemPackages = with pkgs; [
    minecraft
  ];
}
