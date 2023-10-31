{pkgs-unstable, ...}: {
  home.packages = with pkgs-unstable; [
    godot_4
    blender
    krita
  ];
}
