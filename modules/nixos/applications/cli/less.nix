{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.less;
in
  with lib;
{
  options = {
    my.host.applications.cli.less = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables less pager";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      less
    ];
  };
}
