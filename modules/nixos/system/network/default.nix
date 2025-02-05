{config, lib, pkgs, myvars, ...}:

with lib;
let
  role = config.my.host.role;
in
{
  imports = [
    ./firewall
  ];

  options = {
    my.host.system.network.hostname = mkOption {
      type = with types; str;
      default = "null";
      description = "Hostname of system";
    };
    my.host.system.network.domainname = mkOption {
      type = with types; str;
      default = "null";
      description = "Domain name of system";
    };
  };

  config = {
    networking = {
      hostName = config.my.host.system.network.hostname;
      domain = mkDefault "${myvars.domain}";
      useDHCP = mkDefault true;

      networkmanager = mkIf (role == "laptop" || role == "desktop") {
        enable = mkDefault true;
        wifi = {
          scanRandMacAddress = mkDefault true;
          powersave = mkIf (role == "laptop") true;
          backend = "iwd";
        };

      };
    };
  };

}
