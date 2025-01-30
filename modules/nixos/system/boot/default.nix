{config, lib, pkgs, ...}:

let
  cfg = config.my.host.system.boot;
in
  with lib;
{
  options = {
    my.host.system.boot = {
      loader = mkOption {
        default = "systemd";
        type = with types; enum [ "systemd" "grub" ];
        description = "Sets the boot loader";
      };
      timeout = mkOption {
        default = 5;
        type = with types; int;
        description = "The timeout of the bootloader selection screen";
      };
      graphics = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Whether or not to use plymouth for a prettier boot";
        };
        theme = mkOption { # https://github.com/adi1090x/plymouth-themes
          default = "spin";
          type = with types; str;
          description = "What plymouth theme to use";
        };
      };
    };
  };

  config = {
    boot = {
      initrd.systemd.enable = mkIf (cfg.loader == "systemd") true;
      loader = {
        timeout = mkDefault cfg.timeout;
        efi.canTouchEfiVariables = mkIf (cfg.loader == "systemd") true;
        systemd-boot = mkIf (cfg.loader == "systemd") {
          enable = mkDefault true;
          editor = mkDefault false;
          configurationLimit = mkDefault 3;
        };
        grub = mkIf (cfg.loader == "grub") {
          enable = true;
          devices = [ "nodev" ];
          efiInstallAsRemovable = true;
          efiSupport = true;
          useOSProber = true;
        };
      };

      kernelParams = mkIf (cfg.graphics.enable == true) [ "quiet" ];
      plymouth = mkIf (cfg.graphics.enable == true) {
        enable = true;
        theme = "${cfg.graphics.theme}" ;
        # Override the theme to prevent downloading all the themes (over 500MB)
        themePackages = [(pkgs.adi1090x-plymouth-themes.override {
          selected_themes = ["${cfg.graphics.theme}"];
        })];
      };
    };
  };
}
