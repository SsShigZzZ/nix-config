{lib, ...}:

with lib;
{
  imports = [
    ./hardening.nix
    ./firejail.nix
  ];
}
