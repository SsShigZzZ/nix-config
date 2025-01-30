{config, lib, pkgs, ...}:

let
  cfg = config.my.host.features.gaming.gamemode;
in
  with lib;
{
  options = {
    my.host.features.gaming.gamemode = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Optimise Linux system performance on demand";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gamemode
    ];
  };
}
