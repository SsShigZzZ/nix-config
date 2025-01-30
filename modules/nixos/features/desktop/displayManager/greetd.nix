{ config, inputs, lib, pkgs, ... }:
with lib;
let
  desktop = config.my.host.features.desktop;
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  args1 = "--time --remember --remember-session --sessions ${hyprland-session}";
  args2 = "--user-menu --user-menu-min-uid 1000 --user-menu-max-uid 2000";
  hyprland-session = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions";
in

{
  options = {
    my.host.features.desktop.displayManager.greetd = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable greetd";
      };
    };
  };


  config = mkIf (desktop.enable && desktop.displayManager.greetd.enable) {

    environment.systemPackages = [
      pkgs.greetd.gtkgreet
    ];

    services.greetd = {
      enable = true;
      restart = mkIf (desktop.displayManager.autoLogin == true) false;
      settings = {
        default_session = {
          command = "${tuigreet} ${args1} ${args2}";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
