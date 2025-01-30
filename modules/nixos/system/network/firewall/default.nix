{config, lib, ...}:
with lib;
let
  cfg = config.my.host.system.network.firewall;
in
{
  imports = [
    ./fail2ban.nix
    ./opensnitch.nix
  ];

  options = {
    my.host.system.network.firewall = {
      enable = mkOption {
        default = true;
        type = with types; bool;
        description = "Enable firewall (packet filter wrapper)";
      };
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      enable = mkDefault true;
      allowPing = mkIf ( config.my.host.role == "laptop" ) false;
    };
  };
}
