 {config, lib, pkgs, ...}:

let
  cfg = config.my.host.hardware.storage.swap;
  swap_location =
    if cfg.type == "file"
    then cfg.file
    else cfg.partition;
in
  with lib;
{
  options = {
    my.host.hardware.storage.swap = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Swap";
      };
      type = mkOption {
        default = null;
        type = types.enum ["file" "partition"];
        description = "Swap Type";
      };
      encrypt = mkOption {
        default = true;
        type = with types; bool;
        description = "Perform random encryption";
      };
      file = mkOption {
        default = "/swap/swapfile";
        type = with types; str;
        description = "Location of Swapfile";
      };
      partition = mkOption {
        default = "/dev/disk/by-label/swap";
        type = with types; str;
        example = "/dev/sda2";
        description = "Partition to be used for swap";
      };
      size = mkOption {
        type = with types; int;
        default = 8192;
        description = "Size in Megabytes";
      };
    };
  };

  config = mkMerge [

    (mkIf ((cfg.enable) && (cfg.type == "partition")) {
      swapDevices = [{
        device = swap_location;
        randomEncryption.enable = false;
      }];
    })

  {
    systemd.services = mkIf ((cfg.type == "file") && (cfg.enable)) {
      create-swapfile =  {
        serviceConfig.Type = "oneshot";
        wantedBy = [ "swap-swapfile.swap" ];
        script = ''
          swapfile="${cfg.file}"
          if [ -f "$swapfile" ]; then
              echo "Swap file $swapfile already exists, taking no action"
          else
              echo "Setting up swap file $swapfile"
              ${pkgs.coreutils}/bin/truncate -s 0 "$swapfile"
              ${pkgs.e2fsprogs}/bin/chattr +C "$swapfile"
              ${pkgs.btrfs-progs}/bin/btrfs property set "$swapfile" compression none
              ${pkgs.coreutils}/bin/dd if=/dev/zero of="$swapfile bs=1M count=${cfg.size} status=progress
              ${pkgs.coreutils}chmod 0600 ${swapfile}
              ${pkgs.util-linux}/bin/mkswap ${swapfile}
          fi
        '';
      };
    };
  }];
}
