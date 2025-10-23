let
  #disk0 = "/dev/nvme0n1";
  disk0 = "/dev/sda";
in
{
  disko.devices = {
    disk = {
      ${disk0} = {
        device = "${disk0}";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              name = "ESP";
              label = "EFI";
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                extraArgs = ["-nboot"];
              };
            };
            luks = {
              label = "encrypted" ;
              size = "100%";
              content = {
                type = "luks";
                name = "encrypted";
                extraOpenArgs = [ "--allow-discards" ];
                passwordFile = "/tmp/encryption_passphrase";
                content = {
                  type = "lvm_pv";
                  vg = "vg0";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      vg0 = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "4G";
            content = {
              type = "swap";
              resumeDevice = true;
              extraArgs = ["-L vg0-swap"];
            };
          };
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = [
                "-f"
                "-L vg0-root"
              ];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/root-blank" = {
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/home" = {
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/home/active" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/home/snapshots" = {
                  mountpoint = "/home/.snapshots";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/persist" = {
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/persist/active" = {
                  mountpoint = "/persist";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/persist/snapshots" = {
                  mountpoint = "/persist/.snapshots";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/var_lib_docker" = {
                  mountpoint = "/var/lib/docker";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/var_local" = {
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/var_local/active" = {
                  mountpoint = "/var/local";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/var_local/snapshots" = {
                  mountpoint = "/var/local/.snapshots";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/var_log" = {
                  mountpoint = "/var/log";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
