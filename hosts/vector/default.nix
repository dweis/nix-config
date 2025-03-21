{
  pkgs,
  username,
  lib,
  ...
} @ args: let
  hostname = "vector";
in {
  imports = [
    ../../darwin
  ];


  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };

  nix.settings.trusted-users = [username];

}
