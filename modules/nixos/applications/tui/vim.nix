{config, lib, pkgs, ...}:

let
  cfg = config.my.host.applications.tui.vim;
in
  with lib;
{
  options = {
    my.host.applications.tui.vim = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables vim text editor";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
    ];
  };
}
