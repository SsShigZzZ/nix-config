{ config, lib, modulesPath, pkgs, ... }:
with lib;
let
  cfg = config.my.host;
in
{
  imports = [
  ];

  config = mkIf (cfg.role == "desktop" || cfg.role == "laptop") {
    my.host = {
      applications = {
        tui = {
          ranger.enable = mkDefault false;
        };
        gui = {
          firefox.enable = mkDefault true;
        };
      };
      features = {
        desktop = {
          enable = mkDefault true;
          acceleration = mkDefault true;
          fonts = {
            enable = mkDefault true;
          };
          displayManager = {
            greetd.enable = true;
          };
          windowManager = {
            hyprland.enable = true;
          };
        };
      };
      system = {
        powermanagement = {
          enable = mkDefault true;
        };
        boot = {
          timeout = mkDefault 0;
          graphics = {
            enable = mkDefault true;
            theme = mkDefault "circle";
          };
        };
      };
      hardware = {
        av.sound.enable = true;
      };
    };
  };
}
