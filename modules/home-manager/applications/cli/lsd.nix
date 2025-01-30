{config, lib, pkgs, myvars, ...}:
let
  cli = config.my.home.applications.cli;
  cfg = cli.lsd;
in
  with lib;
{
  options = {
    my.home.applications.cli.lsd = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enables home-managered lsd";
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${myvars.userName} = {
      programs = {
        lsd = {
          enable = true;
          enableAliases = true;
          
          colors = {
            user = 230;
            group = 187;
            permission = {
              read = "dark_green";
              write = "dark_yellow";
              exec = "dark_cyan";
              exec-sticky = 5;
              no-access = 245;
              octal = 6;
              acl = "dark_cyan";
              context = "cyan";
            };
            date = {
              hour-old = 72;
              day-old = 72;
              older = 72;
            };
            size = {
              none = 245;
              small = 229;
              medium = 216;
              large = 172;
            };
            inode = {
              valid = 13;
              invalid = 245;
            };
            links = {
              valid = 13;
              invalid = 245;
            };
            tree-edge = 245;
          };

          settings = {
            classic = false;
            date = "+%Y-%m-%d: %H:%M";
            dereference = false;
            no-symlink = false;
            total-size = false;
            symlink-arrow = ">";
            indicators = false;
            layout = "grid";
            size = "default";
            blocks = [
              "permission"
              "user"
              "group"
              "size"
              "date"
              "name"
            ];
            color = {
              when = "auto";
              theme = "custom";
            };
            icons = {
              when = "auto";
              theme = "fancy";
              separator = " ";
            };
            recursion = {
              enabled = false;
            };
            sorting = {
              column = "name";
              reverse = false;
              dir-grouping = "first";
            };
          };
        };
      };
    };
  };
}
