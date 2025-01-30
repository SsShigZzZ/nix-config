{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.wget;
in
  with lib;
{
  options = {
    my.host.applications.cli.wget = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables web downloader";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wget
    ];
  };
}