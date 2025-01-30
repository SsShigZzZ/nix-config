{lib, ...}:

with lib;
{
  imports = [
    ./boot
    ./security
    ./services
    ./powermanagement
    ./network
    ./locale.nix
  ];
}
