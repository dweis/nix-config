{ ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.derrick = {
    isNormalUser = true;
    description = "Derrick Weis";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" "libvirtd" ];
    shell = "/run/current-system/sw/bin/zsh";
  };
}
