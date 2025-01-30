{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.tree;
in
  with lib;
{
  options = {
    my.host.applications.cli.tree = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables tree directory lister";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tree
    ];
  };
}
