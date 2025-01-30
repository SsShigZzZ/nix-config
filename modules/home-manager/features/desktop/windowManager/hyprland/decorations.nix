{ config, lib, myvars, ... }:
with lib;
let
  desktop = config.my.home.features.desktop;
  background = "0A0E14";
  foreground = "B3B1AD";
  black      = "01060E";
  red        = "EA6C73";
  green      = "91B362";
  yellow     = "FAE994";
  blue       = "53BDFA";
  magenta    = "C678DD";
  cyan       = "90E1C6";
  white      = "C7C7C7";
in
{
  config = mkIf (desktop.windowManager.hyprland.enable) {
    home-manager.users.${myvars.userName} = {
      wayland.windowManager.hyprland = {
        settings = {
          # UI
          general = {
            border_size = 5;
            no_border_on_floating = false;
            gaps_in = 7;
            gaps_out = 14;
            resize_on_border = true;
            col.active_border = "rgba(${green}77) rgba(${cyan}77) 45deg";
            col.inactive_border = "rgba(${white}37)";
            col.nogroup_border = "rgba(${white}37)";
            col.nogroup_border_active = "rgba(${green}77) rgba(${cyan}77) 45deg";
            cursor_inactive_timeout = 3;
            no_cursor_warps = false;
            layout = "dwindle";
            no_focus_fallback = true;
            allow_tearing = true;
          };

          master = {
            allow_small_split = true;
            inherit_fullscreen = true;
            new_is_master = true;
            new_on_top = true;
            smart_resizing = true;
          };

          dwindle = {
              pseudotile = true;
              preserve_split = true;
              permanent_direction_override = false;
          };

          decoration = {
            rounding = 8;
            active_opacity = 1.0;
            inactive_opacity = 1.0;
            fullscreen_opacity = 1.0;

            blur = {
                enabled = true;
                size = 5;
                passes = 1;
                ignore_opacity = false;
                xray = false;
                noise = 0.03;
                contrast = 0.86;
                brightness = 0.7;
                special = false;
            };

            drop_shadow = true;
            shadow_range = 4;
            shadow_render_power = 3;
            col.shadow = "rgba(${black}aa)";
            col.shadow_inactive = "rgba(${black}ee)";

            dim_inactive = true;
            dim_strength = 0.3;
            dim_special = 0.3;
            dim_around = 0.3;
          };

          animations = {
            enabled = true;
            bezier = [
              "myBezier, 0.05, 0.9, 0.1, 1.05"
            ];
            animation = [
              "windows, 1, 7, myBezier"
               "windowsOut, 1, 7, default, popin 80%"
               "border, 1, 10, default"
               "borderangle, 1, 8, default"
               "fade, 1, 7, default"
               "workspaces, 1, 6, default"
            ];
          };
        };
      };
    };
  };
}
