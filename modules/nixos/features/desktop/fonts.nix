{config, lib, pkgs, ...}:

let
  cfg = config.my.host.features.desktop.fonts;
  desktop = config.my.host.features.desktop;
in
  with lib;
{
  options = {
    my.host.features.desktop.fonts = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable Fonts";
      };
    };
  };

  config = mkIf cfg.enable {

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

    fonts = mkIf desktop.enable {
      enableDefaultPackages = false;
      fontDir.enable = true;

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
        noto-fonts-cjk-sans
        noto-fonts-emoji
        nerd-fonts.fira-code
        nerd-fonts.hack
      ];

      fontconfig = mkIf desktop.enable {
        enable = mkDefault true;
        antialias = mkDefault true;
        cache32Bit = mkDefault true;
        hinting.enable = mkDefault true;
        hinting.autohint = mkDefault true;
        defaultFonts = {
          serif = [ "Noto Serif NF" "Noto Color Emoji" "IPAPMincho" ];
          sansSerif = [ "Noto Sans NF" "Noto Color Emoji" "IPAPGothic" ];
          monospace = [ "Hack Nerd Font" "Noto Color Emoji" "IPAPGothic" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
