{ pkgs, ... }:

{
  # search packages:
  # - `nix-env -qaP | grep wget`
  # - `nox wget`
  # - https://github.com/NixOS/nixpkgs/

  environment.systemPackages = with pkgs; [
    file
    git
    htop
    iotop
    jq
    lsof
    mkpasswd
    mtr
    nmap
    nox
    oh-my-zsh
    p7zip
    silver-searcher
    tmux
    unzip
    vim
    wget
    zip
    zsh
  ];
}
