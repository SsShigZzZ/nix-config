{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.tui.tmux;
in
  with lib;
{
  options = {
    my.host.applications.tui.tmux = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables terminal multiplexer";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tmux
    ];
  };
}