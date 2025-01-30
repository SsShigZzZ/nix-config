{config, lib, pkgs, ...}:

let
  cfg = config.my.host.system.powermanagement;
  thermald =
    if (config.my.host.hardware.cpu == "intel")
    then true
    else false;
in
  with lib;
{

  imports = [
    ./tlp.nix
    ./laptop.nix
  ];

  options = {
    my.host.system.powermanagement = {
      enable = mkOption {
        default = true;
        type = with types; bool;
        description = "Enables tools and automatic powermanagement";
      };
      laptop = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables laptop powermanagement tools";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hdparm
      power-profiles-daemon
      smartmontools
    ];

    powerManagement = {
      enable = true ;
    };

    services = {
      power-profiles-daemon.enable = mkDefault true;
      thermald.enable = mkDefault thermald;
    };
  };
}
