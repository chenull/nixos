{ config, pkgs, ... }:

rec {

  networking.firewall.enable = false;

  security.sudo.extraConfig = ''
    %admin ALL=(ALL) NOPASSWD:ALL
    %wheel ALL=(ALL) NOPASSWD:ALL
  '';

}
