{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      BlockAboutConfig = true;
      DefaultDownloadDirectory = "${config.home.homeDirectory}/downloads";
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
  };
}
