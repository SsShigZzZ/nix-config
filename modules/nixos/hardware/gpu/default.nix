{config, lib, pkgs, ...}:
  with lib;
{
  imports = [
    ./amd.nix
    ./nvidia.nix
  ];

  options = {
    my.host.hardware.gpu = mkOption {
        type = types.enum [ "amd" "nvidia" null];
        default = null;
        description = "GPU Manufacturer";
    };
  };
}
