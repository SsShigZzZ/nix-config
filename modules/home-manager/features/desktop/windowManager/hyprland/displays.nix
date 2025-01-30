{ config, inputs, lib, pkgs, myvars, specialArgs, ... }:
let
  desktop = config.my.home.features.desktop;
  inherit (specialArgs) displays display_center display_left display_right hostname;
in
with lib;
{
  config = mkIf (desktop.windowManager.hyprland.enable) {
    home-manager.users.${myvars.userName} = {
      wayland.windowManager.hyprland = {
        settings = mkMerge [
          (mkIf (displays == 1) {
            "$monitor_middle" = "${display_center}";
            workspace = [
              "1, monitor:$monitor_middle, default:true"
              "2, monitor:$monitor_middle, default:true"
              "3, monitor:$monitor_middle, default:true"
              "8, monitor:$monitor_middle, default:true"
              "9, monitor:$monitor_middle, default:true"
            ];
          })
          (mkIf (displays == 2) {
            "$monitor_middle" = "${display_center}";
            "$monitor_right" = "${display_right}";
            workspace = [
              "1, monitor:$monitor_middle, default:true"
              "2, monitor:$monitor_middle, default:true"
              "3, monitor:$monitor_middle, default:true"
              "8, monitor:$monitor_right, default:true"
              "9, monitor:$monitor_right, default:true"
            ];
          })
          (mkIf (displays == 3) {
            "$monitor_middle" = "${display_center}";
            "$monitor_right" = "${display_right}";
            "$monitor_left" = "${display_left}";
            workspace = [
              "1, monitor:$monitor_middle, default:true"
              "2, monitor:$monitor_middle, default:true"
              "3, monitor:$monitor_middle, default:true"
              "8, monitor:$monitor_left, default:true"
              "9, monitor:$monitor_right, default:true"
            ];
          })
          (mkIf (hostname == "laptop") {
            monitor = [
              "$monitor_middle,1920x1200,-1920x800,1"
              ",preferred,auto,auto"
            ];
          })
          (mkIf (hostname == "desktop") {
            monitor = [
              "$monitor_left,2560x1440@60,-1440x0,1"
              "$monitor_middle,2560x1440@60,0x0,1"
              ",preferred,auto,auto"
            ];
          })
        ];
      };
    };
  };
}
