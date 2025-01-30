{lib, ...}:

with lib;
{
  imports = [
    ./links.nix
    ./ranger.nix
    ./tmux.nix
    ./vim.nix
  ];
}
