{config, lib, pkgs, myvars, specialArgs, ...}:
let
  cfg = config.my.home.applications.cli.bash;
  icon = if ( specialArgs.role == "desktop" ) then ""
    else if ( specialArgs.role == "laptop" ) then ""
    else "";
  icol = if ( specialArgs.owner == "me" ) then "\\[\\e[32m\\]"
    else if ( specialArgs.owner == "work" ) then "\\[\\e[33m\\]"
    else "\\[\\e[31m\\]";
  pwd_color = "\\[\\e[1;37m\\]";
  git_color = "\\[\\e[1;36m\\]";
  usr_color = "\\[\\e[0;37m\\]";
in
  with lib;
{
  options = {
    my.home.applications.cli.bash = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables home-managered bash";
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${myvars.userName} = {
      programs = {
        bash = {
          enable = true;
          enableCompletion = true;

          historyControl = [ "ignoredups" "ignorespace" ];
          historyFile = "$HOME/.bash_history";
          historyFileSize = 1000000;
          historySize = 10000;
          historyIgnore = [
            "clear"
            "exit"
            "history"
            "ll"
            "ls"
            "lt"
            "pwd"
          ];

          shellOptions = [
            "histappend"
            "cmdhist"
          ];

          shellAliases = {
            camoff = "sudo modprobe -r uvcvideo";
            camon = "sudo modprobe uvcvideo";
            llp = "for i in $(ls $@); do echo -n $(pwd); [[ $(pwd) != '/' ]] && echo -n /; echo $i; done";
            logout = "pkill -KILL -u $USER";
            reboot = "sudo reboot";
          };

          initExtra = ''
            # Get all the extra bits from the config dotfiles
            if [ -d "$HOME/.config/shell/" ] ; then
              for script in $HOME/.config/shell/* ; do
                  source $script
              done
            fi
            
            # Build PS1
            build_ps1 () {
                PS1="${icol} ${icon} "
                PS1+="${pwd_color} $(pwd) "
                [[ $(pwd) =~ $HOME/git/ ]] && git rev-parse --is-inside-work-tree > /dev/null 2>&1 &&
                    PS1+="[${git_color}$(git rev-parse --abbrev-ref HEAD 2>/dev/null)${pwd_color}]"
                PS1+="${pwd_color}\$ ${usr_color}"
            }
            
            export PROMPT_COMMAND=build_ps1
          '';
        };
      };
    };
  };
}
