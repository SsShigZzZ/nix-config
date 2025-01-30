{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.git;
in
  with lib;
{
  options = {
    my.host.applications.cli.git = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables git";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      git-lfs
    ];
  };
}
