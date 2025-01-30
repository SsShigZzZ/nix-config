 {config, lib, pkgs, ...}:

let
  cfg = config.my.host.hardware.storage.encryption;
in
  with lib;
{
  options = {
    my.host.hardware.storage.encryption = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Include LUKS encryption tools";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =  with pkgs; [
      cryptsetup
    ];

  };
}
