{ lib, ... }: {
  services.xserver.videoDrivers = ["qxl"];

  services.qemuGues.enable = true;

  services.spice-vdagentd.enable = lib.mkSure true;
}
