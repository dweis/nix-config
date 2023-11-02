{ pkgs, pkgs-unstable, ... }: {
  services.yabai = {
    enable = true;
    package = pkgs-unstable.yabai;
    enableScriptingAddition = true;
    config = {
      layout = "bsp";
      top_padding = 10;
      right_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      window_gap = 10;
      window_animation_duration = 0.0;
      window_opacity = "on";
      auto_balance = "off";
      focus_follows_mouse = "autofocus";
      mouse_follows_focus = "off";
      window_zoom_persist = "on";
      window_shadow = "on";
      extraConfig = ''
        yabai -m rule --add app="^System Settings$" manage=off
        yabai -m rule --add app="^Calculator$" manage=off
      '';
    };
  };

  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ./skhd/skhdrc;
  };
}
