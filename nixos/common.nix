{ config, inputs, outputs, lib, pkgs, myvars, ... }:
let
  ifGroupExists = groups: builtins.filter
    (group: builtins.hasAttr group config.users.groups) groups;
in
  with lib;
{
  imports = [
    ../users
  ] ++ (builtins.attrValues outputs.nixosModules);

  my = {
    host = {
      features = {
        home-manager.enable = mkDefault true;
      };
      users = {
        root.enable = mkDefault true;
      };
    };
  };

  nix = {
    gc = {
      automatic = mkDefault true;
      dates = mkDefault "18:00";
      persistent = mkDefault true;
      randomizedDelaySec = mkDefault "10min";
      options = mkDefault "--delete-older-than 10d";
    };

    settings = {
      accept-flake-config = true;
      auto-optimise-store = mkDefault true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
    };

    package = pkgs.nixFlakes;
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };

  nixpkgs = {
    config = {
      allowBroken = mkDefault false;
      allowUnfree = mkDefault true;
      allowUnsupportedSystem = mkDefault true;
      permittedInsecurePackages = [
      ];
    };
  };

  system = {
    autoUpgrade.enable = mkDefault false;
    stateVersion = mkDefault "24.05";
  };

  environment = {
    defaultPackages = [];
    enableAllTerminfo = mkDefault false;
  };

  hardware.enableRedistributableFirmware = mkDefault true;

}

