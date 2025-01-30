{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.curl;
in
  with lib;
{
  options = {
    my.host.applications.cli.curl = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables curl";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      curl
    ];
  };
}