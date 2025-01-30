{ config, lib, myvars, ... }:
let
  desktop = config.my.home.features.desktop;
in
with lib;
{
  config = mkIf (desktop.windowManager.hyprland.enable) {
    home-manager.users.${myvars.userName} = {
      wayland.windowManager.hyprland = {
        settings = {
          windowrule = [
            "size 1280 720,^(leagueclientux.exe)$"
            "center,^(leagueclientux.exe)$"
            "center,^(league of legends.exe)$"
            "fullscreen,^(league of legends.exe)$"
            "forceinput,^(league of legends.exe)$"
          ];
          windowrulev2 = [
            "float,title:(Volume Control),class:(pavucontrol)"
            "float,title:(Authentication Required — PolicyKit1 KDE Agent),class:(org.kde.polkit-kde-authentication-agent-1)"
            "noanim,class:(Rofi)"

            # Browser
            "float,title:(Picture-in-Picture),class:(firefox)"
            "float,title:(Close Firefox),class:(firefox)"
            "idleinhibit fullscreen,title:(.*)(YouTube)(.*)$,class:(firefox)"
            "idleinhibit fullscreen,title:^(Netflix)(.*)$,class:(firefox)"
            "idleinhibit fullscreen,title:(.*)(123movies)(.*)$,class:(firefox)"
            "idleinhibit fullscreen,title:(.*)(123Series)(.*)$,class:(firefox)"
            "nodim,class:(firefox)"
            "idleinhibit fullscreen,class:(vlc)"

            # Comms
            "workspace 2 silent,class:(discord)"

            # Work
            "bordercolor rgba($yellow77),class:(Nxplayer.bin)"
            "bordercolor rgba($yellow77),class:(Slack)"
            "nodim,class:(Nxplayer.bin)"
            "nodim,class:(Slack)"
            "nodim,class:(Chromium)"
            "bordercolor rgba($yellow77),title:(Indeed-ubuntu22 on QEMU/KVM),class:(virt-manager)"
            "bordercolor rgba($yellow77),title:(Indeed-ubuntu22 on QEMU/KVM),class:(virt-manager)"
            "bordercolor rgba($yellow77),title:^(Work -)(.*)$,class:(Alacritty)"
            "bordercolor rgba($yellow77),class:(Chromium)"

            # League
            "workspace 3 silent,class:(riotclientux.exe)"
            "workspace 3 silent,class:(riot client.exe)"
            "workspace 3 silent,class:(leagueclientux.exe)"
            "workspace 3 silent,class:(leagueclient.exe)"
            "workspace 3 silent,class:(riotclientservices.exe)"
            "workspace 3 silent,title:(Wine System Tray)"
            "workspace 3,class:(league of legends.exe)"
            "float,class:^(leagueclientux.exe)$,title:^(League of Legends)$"
            "tile,class:^(league of legends.exe)$,title:^(League of Legends (TM) Client)$ windowrule = size 2560 1440,^(league of legends.exe)$"

            # Steam
            "workspace 3 silent,title:(Steam)"
            "workspace 3 silent,class:(steam)"
            "noblur,class:(steam_app)(.*)$"
            "nodim,class:(steam_app)(.*)$"
            "opaque,class:(steam_app)(.*)$"
            "noborder,class:(steam_app)(.*)$"
            "noshadow,class:(steam_app)(.*)$"
            "windowdance,class:(steam_app)(.*)$"
            "noanim,class:(steam_app)(.*)$"
            "nomaxsize,class:(steam_app)(.*)$"
            "immediate,class:(steam_app)(.*)$"
          ];
        };
      };
    };
  };
}
