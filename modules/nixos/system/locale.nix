{ lib, ...}:
  with lib;
{
  i18n = {
    defaultLocale = mkDefault "en_US.UTF-8";
    extraLocaleSettings = {
      LANG = mkDefault "en_US.UTF-8";
      LC_CTYPE = mkDefault "en_US.UTF-8";
      LC_NUMERIC = mkDefault "en_DK.UTF-8";
      LC_TIME = mkDefault "en_DK.UTF-8";
      LC_MONETARY = mkDefault "en_US.UTF-8";
      LC_MESSAGES = mkDefault "en_US.UTF-8";
      LC_PAPER = mkDefault "en_DK.UTF-8";
      LC_NAME = mkDefault "en_DK.UTF-8";
      LC_ADDRESS = mkDefault "en_DK.UTF-8";
      LC_TELEPHONE = mkDefault "en_DK.UTF-8";
      LC_MEASUREMENT = mkDefault "en_DK.UTF-8";
      LC_IDENTIFICATION = mkDefault "en_DK.UTF-8";
    };
  };
  time.timeZone = mkDefault "Asia/Tokyo";
}
