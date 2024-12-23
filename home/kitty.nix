{
  pkgs,
  pkgs-unstable,
  ...
}:
###########################################################
#
# Kitty Configuration
#
# Useful Hot Keys for macOS:
#   1. New Tab: `command + t`
#   2. Close Tab: `command + w`
#   3. Switch Tab: `shift + command + [` | `shift + command + ]`
#   4. Increase Font Size: `command + =` | `command + +`
#   5. Decrease Font Size: `command + -` | `command + _`
#   6. And Other common shortcuts such as Copy, Paste, Cursor Move, etc.
#   7. Search in the current window(show_scrollback): `ctrl + shift + h`
#          This will open a pager, it's defined by `scrollback_pager`, default is `less`
#
#
# Useful Hot Keys for Linux:
#   1. New Tab: `ctrl + shift + t`
#   2. Close Tab: `ctrl + shift + q`
#   3. Switch Tab: `ctrl + shift + right` | `ctrl + shift + left`
#   4. Increase Font Size: `ctrl + shift + =` | `ctrl + shift + +`
#   5. Decrease Font Size: `ctrl + shift + -` | `ctrl + shift + _`
#   6. And Other common shortcuts such as Copy, Paste, Cursor Move, etc.
#
###########################################################
{
  programs.kitty = {
    enable = true;
    package = pkgs-unstable.kitty;
    # kitty has catppuccin theme built-in,
    # all the built-in themes are packaged into an extra package named `kitty-themes`
    # and it's installed by home-manager if `theme` is specified.
    theme = "Catppuccin-Macchiato";
    font = {
      #name = "JetBrainsMono Nerd Font";
      #name = "Monaspace Neon";
      #name = "Iosevka Nerd Font Mono";
      name = "0xProto Nerd Font Mono";
      # use different font size on macOS
      size =
        if pkgs.stdenv.isDarwin
        then 18
        else 14;
    };

    keybindings = {
      "ctrl+shift+m" = "toggle_maximized";
      "ctrl+shift+r" = "noop";
      "command+r" = "noop";
    };

    settings =
      {
        background_opacity = "0.93";
        macos_option_as_alt = true; # Option key acts as Alt on macOS
        macos_quit_when_last_window_closed = true;
        scrollback_lines = 10000;
        enable_audio_bell = false;
        tab_bar_edge = "top"; # tab bar on top
        tab_bar_style = "powerline";
        disable_ligatures = "cursor";
      }
      // (
        if pkgs.stdenv.isDarwin
        then {
          # macOS specific settings, force kitty to use zsh as default shell
          shell = "/run/current-system/sw/bin/zsh";
        }
        else {}
      );

    # macOS specific settings
    darwinLaunchOptions = ["--start-as=maximized"];
  };
}
