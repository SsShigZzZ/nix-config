{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.lsof;
in
  with lib;
{
  options = {
    my.host.applications.cli.lsof = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables listing of open files";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lsof
    ];
  };
}