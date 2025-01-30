{ config, lib, pkgs, ... }:
with lib;
let
  desktop = config.my.host.features.desktop;
in

{
  options = {
    my.host.features.desktop.displayManager.sddm = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable sddm";
      };
    };
  };

  config = mkIf (desktop.enable && desktop.displayManager.sddm.enable) {
    services = {
      displayManager = {
        sddm = {
          enable = mkDefault true;
          wayland.enable = mkDefault true;
          theme = mkDefault "chili";
        };
      };
    };

    environment = {
      systemPackages = with pkgs; [
        sddm-chili-theme
      ];
    };
  };
}
