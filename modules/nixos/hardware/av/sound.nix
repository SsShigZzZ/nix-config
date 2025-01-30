{config, lib, pkgs, ...}:

let
  cfg = config.my.host.hardware.av.sound;
in
  with lib;
{
  options = {
    my.host.hardware.av.sound = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Sound";
      };
      jack_apps = mkOption { 
        default = false;
        type = with types; bool;
        description = "Allow JACK applications";
      };
    };
  };

  config = {

    security.rtkit.enable = mkDefault true;

    services.pipewire = {
      enable = mkDefault true;
      alsa.enable = mkDefault true;
      alsa.support32Bit = mkDefault true;
      pulse.enable = mkDefault true;
      jack.enable = mkIf (cfg.jack_apps) true;

      wireplumber = {
        enable = mkDefault true;
        configPackages = [
          (pkgs.writeTextFile {
             name = "disable-suspend";
             text = ''
               session.suspend-timeout-seconds = 0
             '';
             destination = "/share/wireplumber/main.lua.d/90-suspend-timeout.lua";
          })
        ];
      };
    };

  };
}
