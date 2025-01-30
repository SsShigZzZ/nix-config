{ config, lib, modulesPath, pkgs, specialArgs, ... }:
with lib;
{
  imports = [
  ];

  config = mkIf (specialArgs.role == "desktop" || specialArgs.role == "laptop") {
    my.home = {
      applications = {
        cli = {
          lsd.enable = mkDefault true;
        };
        #tui = {
        #  ranger.home_managed = mkDefault false;
        #};
        #gui = {
        #  firefox.home_managed = mkDefault true;
        #};
      };
      features = {
        desktop = {
      #    acceleration = mkDefault true;
      #    fonts = {
      #      home_managed = mkDefault true;
      #      #home_managed = mkDefault true;
      #    };
      #    displayManager = {
      #      program = mkDefault "greetd";
      #    };
          windowManager = {
            enable = mkDefault true;
            hyprland.enable = mkDefault true;
          };
          fonts.enable = true;
        };
      };
      #system = {
      #  powermanagement = {
      #   .home_managed = mkDefault true;
      #  };
      #  boot = {
      #    timeout = mkDefault 0;
      #    graphics = {
      #     .home_managed = mkDefault true;
      #      theme = mkDefault "circle";
      #    };
      #  };
      #};
      #hardware = {
      #  av.sound.home_managed = true;
      #};
    };
  };
}
