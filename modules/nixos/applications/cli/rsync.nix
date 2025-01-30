{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.rsync;
in
  with lib;
{
  options = {
    my.host.applications.cli.rsync = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables remote syncing tool";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rsync
    ];
  };
}
