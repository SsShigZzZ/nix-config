{lib, ...}:

with lib;
{
  imports = [
    ./backlight.nix
    ./touchpad.nix
  ];
}
