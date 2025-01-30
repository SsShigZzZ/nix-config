{config, lib, pkgs, ...}:

let
  cfg = config.my.host.hardware.input.keyboard;
in
  with lib;
{
  options = {
    my.host.hardware.input.keyboard = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable customizable keyboard support";
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.keyboard.qmk.enable = true;

    environment.systemPackages = with pkgs; [
      qmk
      via
    ];
  };
}
