# ./modules/firefox/firefox.nix
{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      AppAutoUpdate                 = false;
      BackgroundAppUpdate           = false;
      DisableFirefoxStudies         = true;
      DisableFirefoxScreenshots     = true;
      DisableForgetButton           = true;
      DisablePocket                 = true;
      DisableTelemetry              = true;
      BlockAboutConfig              = false;
      DontCheckDefaultBrowser       = true;
      OfferToSaveLogins             = false;

#extentions
      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".installation_mode = "allowed";

        "uBlock0@raymondhill.net" = {
          install_url       = moz "ublock-origin";
          installation_mode = "force_installed";
        };
        "{8754497e-6f81-424a-9e7b-f633d6b0a880}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/simplerentfox/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    profiles.default = { 
      userChrome = builtins.concatStringsSep "\n" [
        (builtins.readFile ./userChrome.css)
          (builtins.readFile ./userContent.css)
      ];
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "layers.acceleration.force-enabled" = true;
        "gfx.webrender.all" = true;
        "svg.context-properties.content.enabled" = true;
        "ui.key.menuAccessKeyFocuses" = false;
        "ui.systemUsesDarkTheme" = 1;
        "layout.css.prefers-color-scheme.content-override" = 2;
        "browser.display.background_color" = "#121212";
      };
      search = {
        force = true;
        default = "ddg";
      };
    };

  };
}
