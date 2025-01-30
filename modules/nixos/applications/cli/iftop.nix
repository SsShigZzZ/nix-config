{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.iftop;
in
  with lib;
{
  options = {
    my.host.applications.cli.iftop = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables network interface measurement";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      iftop
    ];
  };
}