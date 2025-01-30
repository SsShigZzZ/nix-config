{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.tui.ranger;
in
  with lib;
{
  options = {
    my.host.applications.tui.ranger = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables ranger file explorer";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ranger
    ];
  };
}
