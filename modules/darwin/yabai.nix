{
  pkgs,
  pkgs-unstable,
  ...
}: {
  services.yabai = {
    enable = true;
    package = pkgs-unstable.yabai;
    enableScriptingAddition = true;
  };

  services.skhd = {
    enable = true;
    skhdConfig = builtins.readFile ./skhd/skhdrc;
  };
}
