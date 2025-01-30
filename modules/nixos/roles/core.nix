{ config, lib, modulesPath, pkgs, ... }:
  with lib;
{
  imports = [
  ];

  my.host = {
    applications = {
      cli = {
        bash.enable = mkDefault true;
        bind.enable = mkDefault true;
        binutils.enable = mkDefault true;
        coreutils.enable = mkDefault true;
        curl.enable = mkDefault true;
        dmidecode.enable = mkDefault true;
        git.enable = mkDefault true;
        htop.enable = mkDefault true;
        iftop.enable = mkDefault true;
        inetutils.enable = mkDefault true;
        iotop.enable = mkDefault true;
        less.enable = mkDefault true;
        lsof.enable = mkDefault true;
        mtr.enable = mkDefault true;
        pciutils.enable = mkDefault true;
        psmisc.enable = mkDefault true;
        rsync.enable = mkDefault true;
        strace.enable = mkDefault true;
        tree.enable = mkDefault true;
        wget.enable = mkDefault true;
      };
      tui = {
        links.enable = mkDefault true;
        tmux.enable = mkDefault true;
        vim.enable = mkDefault true;
      };
    };
    system = {
      boot = {
        loader = mkDefault "systemd";
      };
      security = {
        hardening.enable = true;
        firejail.enable = false;
      };
      services = {
        logrotate.enable = true;
        ssh.enable = true;
      };
    };
  };
}
