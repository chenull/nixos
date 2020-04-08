{ pkgs, ... }:

{

  imports = [
    ../development/default.nix
    ./vscode.nix
  ];

  environment.systemPackages = with pkgs; [
    dpkg
    # idea-ultimate
    atom
    spyder
  ];

}
