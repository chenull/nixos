{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lolcat
    figlet
    beep
    tldr
    neovim
    xbindkeys
    service-wrapper
    mutt
    neomutt
    zip
    unrar
    rxvt_unicode  # rxvt_unicode-with-plugins
    git-lfs
    exa

    gnupg

    # nix / disk
    ncdu
    nix-du

    # password managers
    # bitwarden-cli
  ];
}
