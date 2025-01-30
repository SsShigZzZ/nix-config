{lib, ...}:

with lib;
{
  imports = [
    ./logrotate.nix
    ./ssh.nix
  ];
}
