{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.my.host.system.security.firejail;
in {
  options = {
    my.host.system.security.firejail = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables firejail";
      };
    };
  };

  config = mkIf cfg.enable {

    programs.firejail = {
      enable = true;
      wrappedBinaries = {
        librewolf = {
          executable = "${pkgs.librewolf}/bin/librewolf";
          profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
          extraArgs = [
            # Required for U2F USB stick
            "--ignore=private-dev"
            # Enforce dark mode
            "--env=GTK_THEME=Adwaita:dark"
            # Enable system notifications
            "--dbus-user.talk=org.freedesktop.Notifications"
          ];
        };
        signal-desktop = {
          executable = "${pkgs.signal-desktop}/bin/signal-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland";
          profile = "${pkgs.firejail}/etc/firejail/signal-desktop.profile";
          extraArgs = [ "--env=GTK_THEME=Adwaita:dark" ];
        };
      };
    };

  };
}
