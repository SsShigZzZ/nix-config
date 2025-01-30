{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.iotop;
in
  with lib;
{
  options = {
    my.host.applications.cli.iotop = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables IO measurement tools";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      iotop
    ];
  };
}