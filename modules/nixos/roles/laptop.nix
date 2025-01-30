{ config, lib, modulesPath, pkgs, ... }:
with lib;
let
  cfg = config.my.host;
in
{
  imports = [
  ];

  config = mkIf (cfg.role == "laptop") {
    my.host = {
      system = {
        powermanagement = {
          laptop = mkDefault true;
          tlp = mkDefault true;
        };
        services = {
          ssh.harden = true;
        };
      };
      hardware = {
        av.webcam.enable = true;
        laptop = {
          backlight.enable = true;
          touchpad.enable = true;
        };
        nic = {
          wireless.enable = true;
          bluetooth.enable = true;
        };
      };
    };
  };
}
