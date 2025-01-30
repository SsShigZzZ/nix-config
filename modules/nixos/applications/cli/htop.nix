{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.htop;
in
  with lib;
{
  options = {
    my.host.applications.cli.htop = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables htop";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      htop
    ];
  };
}