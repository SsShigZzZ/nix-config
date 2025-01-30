{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.gui.firefox;
in
  with lib;
{
  options = {
    my.host.applications.gui.firefox = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables firefox web browser";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      firefox
    ];
  };
}
