{ config, lib, myvars, ... }:
with lib;
let
  desktop = config.my.home.features.desktop;
in
{
  config = mkIf (desktop.windowManager.hyprland.enable) {
    home-manager.users.${myvars.userName} = {
      wayland.windowManager.hyprland = {
        settings = {
          bind = [
            # Session
            "SUPER, M, exit, "
            "SUPER SHIFT, L, exec, $LOCKER"
            "SUPER CTRL, Q, exec, pkill -KILL -u $USER"
            "SUPER CTRL SHIFT, Q, exec, shutdown -h now"
            "SUPER CTRL SHIFT ALT, Q, exec, halt -p"

            # Window
            "SUPER, Q, killactive, "
            "SUPER, F, togglefloating, "
            "SUPER, P, pseudo, # dwindle"
            "SUPER, S, togglesplit, # dwindle"
            "SUPER SHIFT, C, togglespecialworkspace"
            "SUPER SHIFT, RETURN, fullscreen, 1"
            "SUPER CONTROL, RETURN, fullscreen, 0"
            "SUPER, TAB, cyclenext,"
            "SUPER, TAB, alterzorder, top"
            "SUPER SHIFT, TAB, cyclenext, prev"
            "SUPER SHIFT, TAB, alterzorder, top"
            "ALT, TAB, focuscurrentorlast"

            # Music
            "ALT, XF86AudioPlay, exec, mpc --host desktop clear"
            "ALT, XF86AudioPlay, exec, mpc --host desktop load Rock"
            "ALT, XF86AudioPlay, exec, mpc --host desktop shuffle"
            "ALT, XF86AudioPlay, exec, mpc --host desktop play"

            # Apps
            "SUPER, RETURN, exec, $TERMINAL"
            "SUPER ALT, RETURN, exec, $TERMINAL -T \"Work - work-laptop\" -e ssh work-laptop &"
            "SUPER, SPACE, exec, $LAUNCHER"
            "SUPER, O,submap, openapp"
            "SUPER ALT, O,submap, openworkapp"
            "SUPER SHIFT, S, exec, hyprshot -m region --clipboard-only"

            # Focus
            "SUPER, h, movefocus, l"
            "SUPER, l, movefocus, r"
            "SUPER, k, movefocus, u"
            "SUPER, j, movefocus, d"
            "SUPER, left, movefocus, l"
            "SUPER, right, movefocus, r"
            "SUPER, up, movefocus, u"
            "SUPER, down, movefocus, d"

            # Preselect new window direction
            "SUPER CTRL, left,  layoutmsg, preselect l"
            "SUPER CTRL, right, layoutmsg, preselect r"
            "SUPER CTRL, up,    layoutmsg, preselect u"
            "SUPER CTRL, down,  layoutmsg, preselect d"

            # Switch workspaces
            "SUPER, 1, workspace, 1"
            "SUPER, 2, workspace, 2"
            "SUPER, 3, workspace, 3"
            "SUPER, 4, workspace, 4"
            "SUPER, 5, workspace, 5"
            "SUPER, 6, workspace, 6"
            "SUPER, 7, workspace, 7"
            "SUPER, 8, workspace, 8"
            "SUPER, 9, workspace, 9"
            "SUPER, 0, workspace, 10"

            # Move window
            "SUPER SHIFT, left,  movewindow, l"
            "SUPER SHIFT, right, movewindow, r"
            "SUPER SHIFT, up,    movewindow, u"
            "SUPER SHIFT, down,  movewindow, d"

            # Move active window to workspace
            "SUPER SHIFT, 1, movetoworkspace, 1"
            "SUPER SHIFT, 2, movetoworkspace, 2"
            "SUPER SHIFT, 3, movetoworkspace, 3"
            "SUPER SHIFT, 4, movetoworkspace, 4"
            "SUPER SHIFT, 5, movetoworkspace, 5"
            "SUPER SHIFT, 6, movetoworkspace, 6"
            "SUPER SHIFT, 7, movetoworkspace, 7"
            "SUPER SHIFT, 8, movetoworkspace, 8"
            "SUPER SHIFT, 9, movetoworkspace, 9"
            "SUPER SHIFT, 0, movetoworkspace, 10"

            # Scroll through existing workspaces
            "SUPER, mouse_down, workspace, e+1"
            "SUPER, mouse_up, workspace, e-1"
          ];

          binde = [
            # Resize windows
            "SUPER ALT, right, resizeactive, 10 0"
            "SUPER ALT, left, resizeactive, -10 0"
            "SUPER ALT, up, resizeactive, 0 -10"
            "SUPER ALT, down, resizeactive, 0 10"
          ];

          bindel = [
            # Allow media key hold activation even if locked
            ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            "ALT, XF86AudioPrev, exec, mpc --host desktop seek -1"
            "ALT, XF86AudioNext, exec, mpc --host desktop seek +1"
            "ALT, XF86AudioRaiseVolume, exec, mpc --host desktop volume +5"
            "ALT, XF86AudioLowerVolume, exec, mpc --host desktop volume -5"
          ];

          bindm = [
            # Mouse movement of windows
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];
          
          extraConfig = ''
            # Allow media key usage when locked
            bindl  =, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            bindl  =, XF86AudioStop, exec, audioctl shuffle-output

            # Laptops
            bindl=,switch:on:Lid Switch,exec,$LOCKER
            bindl=,switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"
            bindl=,switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, 1920x1200, 0x800, 1.5"

            # Submaps for apps
            submap = openworkapp
                bind = , escape, submap, reset
                bind = , T, exec, $TERMINAL -T "Work - work-macbook" -e ssh work-macbook &
                bind = , T, submap, reset
                bind = , S, exec, slack
                bind = , S, submap, reset
                bind = , B, exec, chromium --proxy-server=work-laptop.pask.xyz:3128
                bind = , B, submap, reset
            submap = reset
            submap = openapp
                bind = , escape, submap, reset
                bind = , T, exec, $TERMINAL
                bind = , T, submap, reset
                bind = , B, exec, $BROWSER
                bind = , B, submap, reset
                bind = , P, exec, $BROWSER --private-window
                bind = , P, submap, reset
                bind = , E, exec, $FILE_EXPLORER
                bind = , E, submap, reset
                bind = , K, exec, open_or_exec keepassxc
                bind = , K, submap, reset
                bind = , R, exec, $LAUNCHER
                bind = , R, submap, reset
                bind = , D, exec, open_or_exec discord
                bind = , D, submap, reset
                bind = , S, exec, open_or_exec steam -dev
                bind = , S, submap, reset
            submap = reset
          '';

        };
      };
    };
  };
}
