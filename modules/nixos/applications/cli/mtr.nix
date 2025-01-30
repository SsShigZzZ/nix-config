{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.mtr;
in
  with lib;
{
  options = {
    my.host.applications.cli.mtr = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables visual network tracerouting";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mtr
    ];
  };
}