{lib, ...}:

with lib;
{
  imports = [
    ./workstation.nix
  ];

  options = {
    my.host.hardware.storage.layout = mkOption {
      type = types.enum [
        "workstation"
        "server"
        "vm"
      ];
    };
  };

}
