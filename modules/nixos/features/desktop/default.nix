{config, lib, pkgs, ...}:
  with lib;
{
  imports = [
    ./displayManager
    ./windowManager
    ./fonts.nix
  ];

  options = {
    my.host.features.desktop = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables desktop environment";
      };
      acceleration = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables graphics acceleration";
      };
    };
  };

  config = mkIf (config.my.host.features.desktop.enable) {
    hardware = {
      opengl = mkIf (config.my.host.features.desktop.acceleration) {
        enable = mkDefault true;
        driSupport = mkDefault true;
        driSupport32Bit = mkDefault true;
      };
    };
    environment.pathsToLink = [ "/libexec" ];
    security.polkit.enable = mkDefault true;
    services.libinput.enable = mkDefault true;
  };
}
