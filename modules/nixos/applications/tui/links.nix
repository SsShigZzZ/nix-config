{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.tui.links;
in
  with lib;
{
  options = {
    my.host.applications.tui.links = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables links";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      links2
    ];
  };
}