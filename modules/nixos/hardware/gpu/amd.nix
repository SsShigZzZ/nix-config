{ config, lib, pkgs, ... }:
  with lib;
let
  device = config.my.host.hardware ;
in {
  config = mkIf (device.gpu == "amd")  {
    boot = mkIf (versionAtLeast pkgs.linux.version "6.2") {
      initrd.kernelModules = ["amdgpu"];
      kernelModules = ["amdgpu"];
    };

    hardware.opengl.extraPackages = with pkgs; [
      amdvlk
      rocmPackages.clr
      rocmPackages.clr.icd
    ];

    services.xserver.videoDrivers = ["amdgpu"];
  };
}
