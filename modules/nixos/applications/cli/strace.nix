{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.strace;
in
  with lib;
{
  options = {
    my.host.applications.cli.strace = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables debugging tools";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      strace
    ];
  };
}