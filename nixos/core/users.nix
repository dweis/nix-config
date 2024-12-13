{...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.derrick = {
    isNormalUser = true;
    description = "Derrick Weis";
    extraGroups = ["wheel" "networkmanager" "audio" "video" "docker" "libvirtd"];
    shell = "/run/current-system/sw/bin/zsh";
    home = "/home/derrick";
    openssh = {
      authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0bF6HZFsTxkLwwGcxOH5wZD9hV18SEbzx/zz7dzewWnKD7z9z1lRmB8TFo7ON/3QhvhTB6PV/pXzSoUCQhJMoZsdSOBAF4Ww4GozYvZ3WtPA3geTIfi2Si76a9oZoOe1mnvls/2QAGyZoTxQcBVK02/HpI7x23IcGcZiaknFf69ZzqCw0eZhVMvzlyz9AUKyJ+MJmXJxCf29Agt26ZW8iu0S1IB9qUxFGVbk/ETARsfNepJrgrNwBskhNWIHsTjnDoc+svxgnyv80QD9fBz9c842YiQfA1jLjX4hg3P92fAfkMmjG/Wq9mtFpP9JVJGUtdEw1qXKcB2idASKcSiI/3eBCJKcOC4ukADlc1J0MpRpOACfdH5fZTjRuRr8BlHcrR09M5R4HlkPlt3A1j0fCuUe5+H5mhbm0ndKeDJ7IZuEPFyWh+bsARY51xfCEYnHt5P+DEFdq+FHRx9/X8mEqvI3Lpwd1WRccnlRByNPssCo1BbLlyeor2pgtiGT4Qz8= laptop"
      ];
    };
  };
}
