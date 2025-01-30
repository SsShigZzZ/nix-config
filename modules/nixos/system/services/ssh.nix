{ config, lib, pkgs, outputs, ... }:
let
  pubKey = host: ../../../../nixos/${host}/secrets/ssh_host_ed25519_key.pub;
  cfg = config.my.host.system.services.ssh;
in
  with lib;
{
  options = {
    my.host.system.services.ssh = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable remote accesa via secure shell";
      };
      extraConfig = mkOption {
        default = "";
        type = types.lines;
        description = "Verbatim contents of sshd_config";
      };
      harden = mkOption {
        default = false;
        type = with types; bool;
        description = "Harden with more secure settings";
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      openssh = {
        enable = true;
        hostKeys = [{
            path = "/etc/ssh/ssh_host_ed25519_key";
            type = "ed25519";
        }];
        openFirewall = mkDefault true ;

        settings = {
          AuthenticationMethods = mkDefault "publickey";
          AcceptEnv = "LANG LC_*";
          ChallengeResponseAuthentication = mkDefault true;
          Ciphers = mkIf cfg.harden [
            "aes256-ctr"
            "aes192-ctr"
            "aes128-ctr"
            "aes256-gcm@openssh.com"
            "aes128-gcm@openssh.com"
            "chacha20-poly1305@openssh.com"
          ];
          GatewayPorts = mkDefault "clientspecified";
          KbdInteractiveAuthentication = mkDefault true;
          KexAlgorithms = mkIf cfg.harden [
            "curve25519-sha256@libssh.org"
            "diffie-hellman-group-exchange-sha256"
            "ecdh-sha2-nistp256"
            "ecdh-sha2-nistp384"
            "ecdh-sha2-nistp521"
          ];
          LoginGraceTime = mkDefault "45s";
          LogLevel = mkDefault "INFO";
          MaxAuthTries = mkDefault 4;
          Macs = mkIf cfg.harden [
            "hmac-sha2-512-etm@openssh.com"
            "hmac-sha2-256-etm@openssh.com"
            "hmac-sha2-512"
            "hmac-sha2-256"
            "umac-128@openssh.com"
            "umac-128-etm@openssh.com"
          ];
          PasswordAuthentication = mkDefault false;
          PermitRootLogin = mkDefault "no" ;
          PermitTunnel = mkDefault true;
          PermitTTY = mkDefault true;
          PrintLastLog = mkDefault true;
          PubkeyAuthentication = mkDefault true;
          RekeyLimit = mkDefault "default 1d";
          StreamLocalBindUnlink = mkDefault true;
          TCPKeepAlive = mkDefault true;
          X11Forwarding = mkDefault true;
          X11UseLocalHost = mkDefault true;
          X11DisplayOffset = mkDefault 10;
        };
        extraConfig = ''
        '';
      };

      fail2ban.jails = mkIf config.my.host.system.network.firewall.fail2ban.enable {
        sshd-aggresive = ''
          enabled = lib.mkForce true
          filter = sshd[mode=aggressive]
        '';
      };
    };

  };
}
