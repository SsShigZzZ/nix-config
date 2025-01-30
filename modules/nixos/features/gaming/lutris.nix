{config, lib, pkgs, ...}:

let
  cfg = config.my.host.features.gaming.lutris;
in
  with lib;
{
  options = {
    my.host.features.gaming.lutris = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Install lutris game explorer";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lutris
    ] ++ (lutris.override {
      extraLibraries =  pkgs: [
        # List library dependencies here (https://nixos.wiki/wiki/Lutris)
      ];
    }) ++ (lutris.override {
       extraPkgs = pkgs: [
         # List package dependencies here (https://nixos.wiki/wiki/Lutris)
       ];
    });
  };
}
