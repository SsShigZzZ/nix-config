{lib, ...}:

with lib;
{
  imports = [
    ./core.nix
    ./desktop.nix
    ./laptop.nix
  ];

  options = {
    my.host.role = mkOption {
      type = types.enum [
        "desktop"
        "laptop"
        "server"
      ];
    };
  };

}
