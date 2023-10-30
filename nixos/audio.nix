{pkgs, ...}: {
  hardware.pulseaudio.enable = false;
  #  hardware.pulseaudio = {
  #    enable = true;
  #    #extraModules = [ pkgs.pulseaudio-modules-bt ];
  #    support32Bit = true;
  #
  #    daemon.config = {
  #      flat-volumes = "no";
  #      default-sample-format = "s24le";
  #      default-sample-rate = "192000";
  #      resample-method = "speex-float-10";
  #      avoid-resampling = "true";
  #    };
  #
  #    package = pkgs.pulseaudioFull;
  #  };
}
