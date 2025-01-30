{config, lib, pkgs, ...}:
let
  cfg = config.my.host.features.desktop.displayManager;
in
  with lib;
{
  imports = [
    ./sddm.nix
    ./greetd.nix
  ];

  options = {
    my.host.features.desktop.displayManager = {
      autoLogin = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Automatically log a user into a session";
        };
        user = mkOption {
          type = with types; str;
          description = "User to auto login";
        };
      };
    };
  };

  config = mkIf (config.my.host.features.desktop.enable) {

    services.xserver.displayManager = mkIf (cfg.autoLogin.enable) {
      autoLogin = {
        enable = mkDefault true;
        user = cfg.autoLogin.user;
      };
    };

  };
}
