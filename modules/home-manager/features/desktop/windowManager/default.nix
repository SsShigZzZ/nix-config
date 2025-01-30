{config, lib, pkgs, myvars, ...}:
  with lib;
let
  desktop = config.my.home.features.desktop;
in
{
  imports = [
    ./hyprland
    ./utilities
  ];
  
  options = {
    my.home.features.desktop.windowManager = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable home management of window manager";
      };
    };
  };

  config = mkIf (desktop.windowManager.enable) {

    home-manager.users.${myvars.userName} = {
      home = {
        packages = with pkgs;
          [
            polkit
            polkit_gnome
            qt5.qtwayland
            qt6.qtwayland
            xdg-utils
          ];

        sessionVariables = {
          QT_QPA_PLATFORM = "wayland";
          SDL_VIDEODRIVER = "wayland";
          XDG_SESSION_TYPE = "wayland";
        };
      };

    };
  };
}
