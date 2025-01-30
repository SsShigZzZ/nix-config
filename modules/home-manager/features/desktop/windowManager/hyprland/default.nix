{ config, inputs, lib, pkgs, myvars, ... }:
with lib;
let
  desktop = config.my.home.features.desktop;
in

{
  imports = [
    ./binds.nix
    ./decorations.nix
    ./displays.nix
    ./input.nix
    ./settings.nix
    ./startup.nix
    ./windowrules.nix
  ];

  options = {
    my.home.features.desktop.windowManager.hyprland = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable hyprland home configuration";
      };
    };
  };

  config = mkIf (desktop.windowManager.hyprland.enable) {

    home-manager.users.${myvars.userName} = {
      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = mkDefault true;
      };

      xsession = {
        enable = true;
        scriptPath = ".hm-xsession";

        windowManager.command = ''
          export CLUTTER_BACKEND=gdk
          export MOZ_ENABLE_WAYLAND=1
          export QT_AUTO_SCREEN_SCALE_FACTOR=1
          export QT_QPA_PLATFORM=wayland
          export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
          export SDL_VIDEODRIVER=wayland
          export WLR_RENDERER=vulkan
          export XDG_CURRENT_DESKTOP=Hyprland
          export XDG_SESSION_DESKTOP=Hyprland
          export XDG_SESSION_TYPE=wayland
          export _JAVA_AWT_WM_NONREPARENTING=1
          Hyprland
        '';
      };
    };

  };
}
