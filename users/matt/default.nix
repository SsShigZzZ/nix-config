{ config, lib, pkgs, ... }:
let
  ifGroupExists = groups: builtins.filter
    (group: builtins.hasAttr group config.users.groups) groups;
in
  with lib;
{
  options = {
    my.host.users.matt = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Matt";
      };
    };
  };

  config = mkIf config.my.host.users.matt.enable {
    users = {
      mutableUsers = mkDefault true;
      users.matt = {
        isNormalUser = true;
        shell = pkgs.bashInteractive;
        uid = 5000;
        group = "users" ;
        extraGroups = [
          "wheel"
          "video"
          "audio"
        ] ++ ifGroupExists [
          "docker"
          "git"
          "input"
          "libvirtd"
          "network"
          "networkmanager"
        ];

        initialHashedPassword =
          "$y$j9T$LGkCu7k9v5dEiWknEc9/y1$m3PbQD/LoUUyWxAj05mVcnG22hz5.Uh0wNYG/Id/wR8";
      };
    };
  };
}
