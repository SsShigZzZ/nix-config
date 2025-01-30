{lib, ...}:

with lib;
{
  imports = [
    ./hyprcursor.nix
    ./hyprdim.nix
    ./hypridle.nix
    ./hyprkeys.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpicker.nix
    ./hyprshot.nix
    ./mako.nix
    ./waybar.nix
  ];
}
