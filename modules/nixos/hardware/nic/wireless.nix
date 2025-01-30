{config, lib, pkgs, ...}:

let
  cfg = config.my.host.hardware.nic.wireless;
in
  with lib;
{
  options = {
    my.host.hardware.nic.wireless = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables tools for wireless";
      };
    };
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      iw
    ];

    hardware.wirelessRegulatoryDatabase = true;
  };
}
