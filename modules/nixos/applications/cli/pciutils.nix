{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.pciutils;
in
  with lib;
{
  options = {
    my.host.applications.cli.pciutils = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables toosl for working with hardware devices";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pciutils
    ];
  };
}