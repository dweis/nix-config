{ ... }: {
  services.xserver.videoDrivers = ["qxl"];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  services.spice-webdavd.enable = true;  # For file sharing support
  security.polkit.enable = true;
}
