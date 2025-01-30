{ config, lib, pkgs, ... }:
let
  ifGroupExists = groups: builtins.filter
    (group: builtins.hasAttr group config.users.groups) groups;
in
  with lib;
{
  options = {
    my.host.users.media = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Media";
      };
    };
  };

  config = mkIf config.my.host.users.media.enable {
    users.users.media = {
      isNormalUser = true;
      shell = pkgs.bashInteractive;
      uid = 10000;
      group = "users" ;
      extraGroups = [
        "video"
        "audio"
      ] ++ ifTheyExist [
        "adbusers"
        "deluge"
        "docker"
        "git"
        "input"
        "libvirtd"
        "network"
        "podman"
      ];

    };
  };
}
