{ config, lib, pkgs, ... }:
with lib;
let
  sys = config.my.host.hardware;
  cfg = config.my.host.system.security.hardening;
in {
  options = {
    my.host.system.security.hardening = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables security hardening features";
      };
      enable_audit = mkOption {
        default = false;
        type = with types; bool;
        description = "Logs with auditd";
      };
    };
  };

  config = mkIf cfg.enable {
    security = {
      protectKernelImage = true;
      lockKernelModules = false;
      forcePageTableIsolation = true;
      allowUserNamespaces = true;

      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
        packages = [ pkgs.apparmor-profiles ];
      };

      virtualisation.flushL1DataCache = "always";

      # log polkit request actions
      polkit.extraConfig = ''
        polkit.addRule(function(action, subject) {
          polkit.log("user " +  subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
        });
      '';

      auditd.enable = mkIf ( cfg.enable_audit == true ) true;
      audit = mkIf ( cfg.enable_audit == true ) {
        enable = true;
        backlogLimit = 8192;
        failureMode = "printk";
        rules = [ "-a exit,always -F arch=b64 -S execve" ];
      };

      pam = {
        loginLimits = [
          {
            domain = "@wheel";
            item = "nofile";
            type = "soft";
            value = "524288";
          }
          {
            domain = "@wheel";
            item = "nofile";
            type = "hard";
            value = "1048576";
          }
        ];

      };

      sudo = {
        wheelNeedsPassword = mkDefault true;
        enable = mkDefault true;
        execWheelOnly = mkDefault true;
        extraConfig = ''
          Defaults lecture = never # rollback results in sudo lectures after each reboot
          Defaults pwfeedback
          Defaults env_keep += "EDITOR PATH"
          Defaults timestamp_timeout = 300
          Defaults passprompt="[31m sudo: password for %p@%h, running as %U:[0m "
        '';
      };
    };

    boot.kernel.sysctl = {
      # The Magic SysRq key is a key combo that allows users connected to the
      # system console of a Linux kernel to perform some low-level commands.
      # Disable it, since we don't need it, and is a potential security concern.
      "kernel.sysrq" = 0;
      # Restrict ptrace() usage to processes with a pre-defined relationship
      # (e.g., parent/child)
      "kernel.yama.ptrace_scope" = 2;
      # Hide kptrs even for processes with CAP_SYSLOG
      "kernel.kptr_restrict" = 2;
      # Disable bpf() JIT (to eliminate spray attacks)
      "net.core.bpf_jit_enable" = false;
      # Disable ftrace debugging
      "kernel.ftrace_enabled" = false;
    };

    boot.blacklistedKernelModules = [
      # Obscure network protocols
      "ax25"
      "netrom"
      "rose"
      # Old or rare or insufficiently audited filesystems
      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "vivid"
      "gfs2"
      "ksmbd"
      "nfsv4"
      "nfsv3"
      "cifs"
      "nfs"
      "cramfs"
      "freevxfs"
      "jffs2"
      "hfs"
      "hfsplus"
      "squashfs"
      "udf"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
    ] ++ lib.optionals (!sys.av.webcam.enable) [
      "uvcvideo"
    ] ++ lib.optionals (!sys.nic.bluetooth.enable) [
      "btusb"
    ];
  };
}
