{ inputs, outputs, lib, config, pkgs, myvars,... }:
with lib;
{
  imports = [
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  options = {
    my.owner = mkOption {
      default = null;
      type = types.enum [ "me" "work" null ];
      description = "Owner of the device";
    };
  };

  config = {
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };

    home-manager = {
      backupFileExtension = "backup";
      
      users."${myvars.userName}" = {
        home = {
          username = "${myvars.userName}";
          homeDirectory = "/home/${myvars.userName}";
          stateVersion = "24.05";
        };
      };

    };
  };

}
