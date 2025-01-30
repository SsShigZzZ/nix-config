{config, lib, pkgs, ...}:

let
  cfg = config.my.host.hardware.laptop.touchpad;
in
  with lib;
{
  options = {
    my.host.hardware.laptop.touchpad = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables touchpad support";
      };
    };
  };

  config = mkIf cfg.enable {

    services = {
      xserver.libinput = {
        enable = true;
        mouse = {
          accelProfile = mkDefault "flat";
          accelSpeed = mkDefault "0";
          middleEmulation = mkDefault false;
        };
        touchpad = {
          clickMethod = "clickfinger";
          disableWhileTyping = mkDefault false;
          horizontalScrolling = mkDefault false;
          naturalScrolling = mkDefault true;
          sendEventsMode = mkDefault "enabled";
          tapping = mkDefault true;
        };
      };
    };

  };
}
