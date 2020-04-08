# https://github.com/ghuntley/dotfiles-nixos/tree/master/machines
{ pkgs, ... }:

{
  imports = [
    ../profiles/os/default.nix
    ../profiles/os/shells.nix
    ../profiles/os/insecure.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/xvda";

  # Speed up development at the cost of possible build race conditions
  nix.buildCores = 2;

  # ID
  networking.hostName = "nixsri";
  networking.interfaces.eth0.useDHCP = false;
  networking.interfaces.eth1.useDHCP = true;

  # Version
  system.stateVersion = "19.09";

}
