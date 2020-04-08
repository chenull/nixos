{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration-common.nix
    ./machines/nixsri.nix
  ];


  # Home Manager disabled, nunggu 20.03 dulu
  # home-manager = {
  #  enable = true;
  #  useUserPackages = true;
  #  useGlobalPkgs = true;
  # };

}

