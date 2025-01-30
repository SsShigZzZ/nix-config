{config, lib, pkgs, ...}:

let
  cfg = config.my.home.applications.cli.playerctl;
  desktop = config.my.home.features.desktop;
in
  with lib;
{
  options = {
    my.home.applications.cli.playerctl = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Media Keys tool";
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${myvars.userName} = {
      home = {
        packages = with pkgs;
          [
            playerctl
          ];
      };

      wayland.windowManager.hyprland = mkIf (desktop.windowManager.hyprland.enable) {
        settings = {
          bindl = [
            ",XF86AudioPlay, exec, playerctl play-pause"
            ",XF86AudioPrev, exec, playerctl previous"
            ",XF86AudioNext, exec, playerctl next"
          ];
        };
      };
    };
  };
}
