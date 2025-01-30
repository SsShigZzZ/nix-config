{lib, ...}:

with lib;
{
  imports = [
    ./keyboard.nix
    ./yubikey.nix
  ];
}
