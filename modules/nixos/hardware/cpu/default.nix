{config, lib, ...}:
with lib;
let
  device = config.my.host.hardware;
in {
  imports = [
    ./intel.nix
    ./amd.nix
  ];

  options = {
    my.host.hardware = {
      cpu = mkOption {
        type = types.enum ["amd" "intel" "vm-amd" "vm-intel" null];
        default = null;
        description = "CPU manufacturer";
      };
    };
  };

  config = {

    nixpkgs.hostPlatform = mkIf ( device.cpu == "intel" ||
      device.cpu == "vm-intel" ||
      device.cpu == "vm-amd" ||
      device.cpu == "amd" ) "x86_64-linux";

    virtualisation.virtualbox.guest.enable = mkIf 
      ( device.cpu == "vm-intel" || device.cpu == "vm-amd" ) true;

  };

}
