{config, lib, pkgs, ...}:

let
  cfg = config.my.host.hardware.av.webcam;
in
  with lib;
{
  options = {
    my.host.hardware.av.webcam = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Webcam support";
      };
    };
  };

  config = mkIf cfg.enable {
    boot.kernelParams = ["uvcvideo"];
  };
}
