# see `nixos-help`, https://nixos.org/nixos/options.html
# https://github.com/ghuntley/dotfiles-nixos/blob/master/configuration-common.nix

# Most of the configuration is in here. This configuration is common to both
# conventional NixOS installs (see nixos-install) and NixOS installed by
# Nixops. For configuration specific to conventional installs and Nixops
# installs, see ./configuration.nix and ./nixops.nix respectively.

{ config, lib, pkgs, ... }:
with lib;

{
  imports = [
    ./services/default.nix
    ./profiles/applications/vim
    ./users/ayik.nix
  ];

  # Allow proprietary software (such as the NVIDIA drivers).
  nixpkgs.config.allowUnfree = true;

  boot = {

    # See console messages during early boot.
    initrd.kernelModules = [ "fbcon" ];

    # Disable console blanking after being idle.
    kernelParams = [ "consoleblank=0" ];
 
    # Clean /tmp on boot
    cleanTmpDir = true;

  };
 
  # disable autoupgrade
  system.autoUpgrade = {
    enable = false;
  };

  # Nix
  nix = {
    extraOptions = ''
      auto-optimise-store = true
    '';

    gc = {
      automatic = true;
      dates = "02:15";
      options = "--delete-older-than 30d";
    };
  };

  # Basic Security
  security = {
    # sudo
    sudo.enable = true;
    # restrict process info access to owning user
    hideProcessInformation = true;
    # wheel
    pam.services.su.requireWheel = true;
  };

  # Disable displaying the NixOS manual in a virtual console.
  services.nixosManual.showManual = false;

  # Disable the infamous systemd screen/tmux killer
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    extraConfig = ''
      HandlePowerKey=suspend
      KillUserProcesses=no
    '';
  };

  # Increase the amount of inotify watchers
  # Note that inotify watches consume 1kB on 64-bit machines.
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches"   = 1048576;   # default:  8192
    "fs.inotify.max_user_instances" =    1024;   # default:   128
    "fs.inotify.max_queued_events"  =   32768;   # default: 16384
  };

  time.timeZone = "Asia/Jakarta";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  programs.gnupg.agent = {
    enable = false;
    enableSSHSupport = false;
  };
}
