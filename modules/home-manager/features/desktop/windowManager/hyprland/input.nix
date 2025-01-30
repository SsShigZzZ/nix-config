{ config, inputs, lib, pkgs, myvars, ... }:
let
  desktop = config.my.home.features.desktop;
in
with lib;
{
  config = mkIf (desktop.windowManager.hyprland.enable) {
    home-manager.users.${myvars.userName} = {
      wayland.windowManager.hyprland = {
        settings = {
          input = {
            kb_layout = "us";
            numlock_by_default = true;
            repeat_rate = 40;
            repeat_delay = 350;

            touchpad = {
              natural_scroll = false;
            };

            follow_mouse = 2;
            sensitivity = -0.38;
          };

          gestures = {
            workspace_swipe = false;
            workspace_swipe_fingers = 3;
          };
        };
      };
    };
  };
}
