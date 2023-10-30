{ pkgs, ... }:

{
  users.users.derrick.packages = [
    pkgs.steam
  ];
}