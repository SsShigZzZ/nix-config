{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.bind;
in
  with lib;
{
  options = {
    my.host.applications.cli.bind = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables name resolution tools";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bind
    ];
  };
}