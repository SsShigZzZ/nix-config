{config, lib, pkgs, ...}:

let
  cfg = config.my.host.hardware.input.yubikey;
in
  with lib;
{
  options = {
    my.host.hardware.input.yubikey = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Yubikey support";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      yubikey-personalization
      yubikey-personalization-gui
      yubico-piv-tool
      yubioath-flutter
    ];

  };
}
