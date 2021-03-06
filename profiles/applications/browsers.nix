{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    firefox-devedition-bin
    google-chrome
    brave
  ];

  nixpkgs.config = {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/browsers/firefox/wrapper.nix
    # ~/.mozilla/firefox/*.default/browser-extension-data/
    firefox = {
      jre = false;
      enableAdobeFlash = false;
      enableGnomeExtensions = true;
      # TODO: ^ debug https://extensions.gnome.org/ error "native host connector is not detected"
    };

  };

}
