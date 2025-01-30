{lib, ...}:

with lib;
{
  imports = [
    ./core.nix
    ./desktop.nix
#    ./laptop.nix
  ];

  options = {
    my.home.role = mkOption {
      type = types.enum [
        "desktop"
        "laptop"
        "server"
      ];
    };
  };

}
