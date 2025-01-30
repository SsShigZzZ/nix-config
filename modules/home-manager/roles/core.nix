{ config, lib, modulesPath, pkgs, ... }:
  with lib;
{
  imports = [
  ];

  my.home = {
    applications = {
      cli = {
        bash.enable = mkDefault true;
      };
#      gui = {
#      };
#      tui = {
#        nvim.enable = mkDefault true;
#      };
    };
  };
}
