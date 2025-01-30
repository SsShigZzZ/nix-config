{config, lib, pkgs, myvars, ...}:

let
  cfg = config.my.home.features.desktop.fonts;
  desktop = config.my.home.features.desktop;
in
  with lib;
{
  options = {
    my.home.features.desktop.fonts = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Fonts";
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${myvars.userName} = {
      home = {
        packages = with pkgs; [
          carlito
          dejavu_fonts
          vegur
          source-code-pro
          ipafont #JP
          kochi-substitute #JP
          jetbrains-mono
          font-awesome
          corefonts
          noto-fonts
          noto-fonts-cjk
          noto-fonts-emoji
          (nerdfonts.override {
            fonts = [
              "FiraCode"
              "Hack"
            ];
          })
        ];
      };
    };

    # Japanese
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-anthy
        fcitx5-gtk
        fcitx5-mozc
      ];
      ibus.engines = with pkgs.ibus-engines; [ mozc ];
    };

    fonts.fontconfig = {
      enable = mkDefault true;
      defaultFonts = {
        serif = [ "Noto Serif NF" "Noto Color Emoji" "IPAPMincho" ];
        sansSerif = [ "Noto Sans NF" "Noto Color Emoji" "IPAPGothic" ];
        monospace = [ "Hack Nerd Font" "Noto Color Emoji" "IPAPGothic" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
