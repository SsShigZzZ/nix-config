{ config, inputs, lib, pkgs, ... }:
with lib;
let
  desktop = config.my.host.features.desktop;
in

{
  options = {
    my.host.features.desktop.windowManager.hyprland = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable hyprland";
      };
    };
  };

  config = mkIf (desktop.enable && desktop.windowManager.hyprland.enable) {

    programs = {
      hyprland = {
        enable = mkDefault true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs;  [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];

      wlr = {
        enable = true;
        settings = {
          screencast = {

          };
        };
      };
    };

  };
}
