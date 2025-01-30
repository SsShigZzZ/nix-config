{ config, lib, pkgs, ... }:
  with lib;
{
  options = {
    my.host.users.root = {
      enable = mkOption {
        default = true;
        type = with types; bool;
        description = "Enable root";
      };
    };
  };

  config = mkIf config.my.host.users.root.enable {
    users.users.root = {
      shell = pkgs.bashInteractive;
      #hashedPasswordFile = mkDefault config.sops.secrets.root-password.path;
    };

    #sops.secrets.root-password = {
    #  sopsFile = mkDefault ../secrets.yaml;
    #  neededForUsers = mkDefault true;
    #};
  };
}
