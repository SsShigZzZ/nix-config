{lib, ...}:

with lib;
{
  imports = [
    ./bluetooth.nix
    ./wireless.nix
  ];
}
