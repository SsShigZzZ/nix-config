{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.coreutils;
in
  with lib;
{
  options = {
    my.host.applications.cli.coreutils = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables coreutils";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      coreutils
    ];
  };
}