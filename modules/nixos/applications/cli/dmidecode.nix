{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.cli.dmidecode;
in
  with lib;
{
  options = {
    my.host.applications.cli.dmidecode = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables dmidecode";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dmidecode
    ];

  };
}
