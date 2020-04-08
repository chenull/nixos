{ pkgs, ... }:

let
  pkgs = import <nixpkgs> {
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = with pkgs; [
    nodejs
    yarn
    # postman
  ] ++ (with nodePackages; [
    npm
    node-gyp-build
    webpack
  ]);
}
