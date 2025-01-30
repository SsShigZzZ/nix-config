{config, lib, pkgs, ...}:

let
  cfg = config.my.host.hardware.nic.bluetooth;
in
  with lib;
{
  options = {
    my.host.hardware.nic.bluetooth = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Bluetooth";
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
      powerOnBoot = true;
      disabledPlugins = ["sap"];
      settings = {
        General = {
          JustWorksRepairing = "always";
          MultiProfile = "multiple";
        };
      };
    };

    services.blueman.enable = true;

  };
}
