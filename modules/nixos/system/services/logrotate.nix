{config, lib, pkgs, ...}:

let
  cfg = config.my.host.system.services.logrotate;
in
  with lib;
{
  options = {
    my.host.system.services.logrotate = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables log rotation";
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      logrotate = {
        enable = true;
        settings.header = {
          global = mkDefault true;
          priority = mkDefault 1;
          frequency = mkDefault "daily";
          rotate = mkDefault 7;
          dateext = mkDefault true;
          dateformat = mkDefault "-%Y-%m-%d";
          nomail = mkDefault true;
          notifempty = mkDefault true;
          missingok = mkDefault true;
          copytruncate = mkDefault true;
          compress = mkDefault true;
        };
      };
    };
  };
}
