{config, lib, pkgs, ...}:
let
  cfg = config.my.host.applications.cli.bash;
in
  with lib;
{
  options = {
    my.host.applications.cli.bash = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables bash";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bashInteractive
    ];

    programs = {
      bash = {
        enableCompletion = true ;
        shellInit = ''
              export HISTFILE=/$HOME/.bash_history
              shopt -s histappend   # Append to history file
              shopt -s cmdhist      # Save multiline commands

              ## After each command, append to the history file and reread it
              export PROMPT_COMMAND="''${PROMPT_COMMAND:+$PROMPT_COMMAND$"\n"}history -a; history -c; history -r"

              HISTFILESIZE=1000000  # File size (lines)
              HISTSIZE=3000         # File size (memory)

              HISTTIMEFORMAT="%Y%m%d.%H%M%S%z "

              export HISTIGNORE="ls:ls -lart:pwd:clear:history:ps"

              HISTCONTROL=ignoreboth  # Ignore dupes & cmds starting with space
        '';
      };
    };
  };
}
