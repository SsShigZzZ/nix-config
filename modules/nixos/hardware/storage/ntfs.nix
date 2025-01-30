{config, lib, pkgs, ...}:

let
  cfg = config.my.host.hardware.storage.ntfs;
in
  with lib;
{
  options = {
    my.host.hardware.storage.ntfs = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables support for reading NTFS drives";
      };
    };
  };

  config = mkIf cfg.enable {
    boot = {
      supportedFilesystems = [
        "ntfs"
      ];
    };
  };
}
