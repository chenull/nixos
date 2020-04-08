# https://github.com/ghuntley/dotfiles-nixos/blob/master/users/ghuntley.nix

{ lib, pkgs, ... }: # config, 
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ayik = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/ayik";
    description = "Sayid Munawar <ayik@jogjacamp.co.id>";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDuqNIYxmYSGT63RIwzjXI61Hpu1PrsRT+begu9iIOTBdqe8P7Plnu/8l7TPpiDecWCBTHz2x4m1b7Plt7RNPhsQUmgSdNXZa6MJMtmpWKHC7SyCaHfOZ3yTRD9/ECBp/nN2Esd70H7mwWJZbFqRRaOhxcwclJD+spp25WkStcALLSUiMgqbTs4Rj/Us/3XXa02zge+zYCwpQAvJeOi6tmLstpKs7StMv15+bhV2aQTeIRzN0RqchfFij6pzRNCpTjmkPOvimDRUWyCo1SuKRgps9t9fPI1yySlGFvxoEKa0kkpvuUYi6Z/RA+zdhTLBiVIdkIaOmhv7070Lowj2axr ayik@McAvis.local"
    ];
  };

  environment.variables.DEFAULT_USER = "ayik";

}
