{ config, inputs, lib, pkgs, ...}: {

  imports = [
    ../common.nix
  ];

  my = {
    host = {
#      role = "desktop";
      role = "core";
      hardware = {
        cpu = "vm-amd";
#        gpu = "nvidia";
        storage = {
          layout = "workstation";
          btrfs = {
            enable = true;
            autoscrub = true;
          };
          tmpfs = {
            enable = true;
            size = "50%";
          };
          swap = {
            enable = true;
            type = "partition";
          };
          encryption.enable = true;
          ntfs.enable = true;
        };
        input.keyboard.enable = true;
      };
      system.network = {
        hostname = "desktop";
      };
      users = {
        matt.enable = true;
      };
#      features = {
#        gaming = {
#          gamemode.enable = true;
#          lutris.enable = true;
#          steam = {
#            enable = true;
#            protonGE = true;
#          };
#        };
#      };
    };

  };

}
