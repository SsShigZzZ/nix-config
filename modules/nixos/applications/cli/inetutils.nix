{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.inetutils;
in
  with lib;
{
  options = {
    my.host.applications.cli.inetutils = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables various internet utilities";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inetutils
    ];
  };
}