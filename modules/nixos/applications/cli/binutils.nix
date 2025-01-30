{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.binutils;
in
  with lib;
{
  options = {
    my.host.applications.cli.binutils = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables binutils";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      binutils
    ];
  };
}