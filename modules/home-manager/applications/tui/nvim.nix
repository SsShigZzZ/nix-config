{config, lib, pkgs, ...}:

let
  cfg = config.my.home.applications.tui.nvim;
in
  with lib;
{
  options = {
    my.home.applications.tui.nvim = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables nvim text editor";
      };
    };
  };

  #config = mkIf cfg.enable {
  #  environment.systemPackages = with pkgs; [
  #    neovim
  #  ];
  #};
}
