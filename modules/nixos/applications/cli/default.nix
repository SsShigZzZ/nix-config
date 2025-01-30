{lib, ...}:

with lib;
{
  imports = [
    ./bash.nix
    ./bind.nix
    ./binutils.nix
    ./coreutils.nix
    ./curl.nix
    ./dmidecode.nix
    ./git.nix
    ./htop.nix
    ./iftop.nix
    ./inetutils.nix
    ./iotop.nix
    ./less.nix
    ./lsof.nix
    ./mtr.nix
    ./pciutils.nix
    ./psmisc.nix
    ./rsync.nix
    ./strace.nix
    ./tree.nix
    ./wget.nix
  ];
}
