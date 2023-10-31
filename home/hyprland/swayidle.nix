{pkgs, ...}: {
#  services.swayidle = {
#    enable = true;
#    systemdTarget = "graphical-session.target";
#    # TODO: Make dynamic for window manager
#    events = [
#      {
#        event = "before-sleep";
#        command = "${pkgs.swaylock}/bin/swaylock -df -c /home/derrick/.config/swaylock/config";
#      }
#      {
#        event = "after-resume";
#        command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
#      }
#      {
#        event = "lock";
#        command = "${pkgs.swaylock}/bin/swaylock -df -c /home/derrick/.config/swaylock/config";
#      }
#    ];
#    timeouts = [
#      {
#        timeout = 900;
#        command = "${pkgs.swaylock}/bin/swaylock -df -c /home/derrick/.config/swaylock/config";
#      }
#      {
#        timeout = 1200;
#        command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
#      }
#    ];
#  };
}
