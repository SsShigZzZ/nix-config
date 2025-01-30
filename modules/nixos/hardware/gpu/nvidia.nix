{ config, lib, pkgs, ... }:
  with lib;
let
  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;

  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';

  nvidiaPackage =
    if (versionOlder nvBeta nvStable)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;

  device = config.my.host.hardware;
in {
  config = mkIf (device.gpu == "nvidia")  {
    nixpkgs.config.allowUnfree = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    boot = {
      blacklistedKernelModules = [
        "nouveau"
      ];
    };

    environment = {
      sessionVariables = mkMerge [
        (mkIf (config.my.host.features.desktop.enable) {
          LIBVA_DRIVER_NAME = "nvidia";
        })

        (mkIf (config.my.host.features.desktop.enable == true) {
          WLR_NO_HARDWARE_CURSORS = "1";
        })

      ];
      systemPackages = with pkgs; mkIf (config.my.host.features.desktop.enable) [
        libva
        libva-utils
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
      ];
    };

    hardware = {
      nvidia = {
        package = mkDefault nvidiaPackage;
        modesetting.enable = mkDefault true;
        powerManagement = {
          enable = mkDefault true;
        };

        open = mkDefault false;
        nvidiaSettings = false;
        nvidiaPersistenced = true;
        forceFullCompositionPipeline = true;
      };

      opengl = {
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];
      };
    };
  };
}
