{ config, lib, pkgs, myvars, ... }:
let
  desktop = config.my.home.features.desktop;
in
with lib;
{

  config = mkIf (desktop.windowManager.hyprland.enable) {
    home-manager.users.${myvars.userName} = {
      wayland.windowManager.hyprland = {
        #settings = {
        #  ## Add setting blocks to modules
        #};
      };
    };
  };
}
