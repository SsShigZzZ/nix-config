{config, lib, pkgs, ...}:
  with lib;
{
  imports = [
    ./windowManager
    ./fonts.nix
  ];
}
