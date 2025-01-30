{lib, ...}:

with lib;
{
  imports = [
    ./layouts
    ./btrfs.nix
    ./encryption.nix
    ./ntfs.nix
    ./swap.nix
    ./tmp.nix
  ];
}
