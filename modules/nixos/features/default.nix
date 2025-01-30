{lib, ...}:

with lib;
{
  imports = [
    ./gaming
    ./desktop
    ./multimedia
    ./home-manager.nix
  ];
}
