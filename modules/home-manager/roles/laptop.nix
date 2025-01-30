{ config, lib, modulesPath, pkgs, specialArgs, ... }:
with lib;
{
  imports = [
  ];

  config = mkIf (specialArgs.role == "laptop") {
    my.home = {
      #system = {
      #  powermanagement = {
      #    laptop = mkDefault true;
      #    tlp = mkDefault true;
      #  };
      #  services = {
      #    ssh.harden = true;
      #  };
      #};
      #hardware = {
      #  av.webcam.home_managed = true;
      #  laptop = {
      #    backlight.home_managed = true;
      #    touchpad.home_managed = true;
      #  };
      #  nic = {
      #    wireless.home_managed = true;
      #    bluetooth.home_managed = true;
      #  };
      #};
    };
  };
}
