{ pkgs, ... }:

let
  my-python-packages = python-packages: with python-packages; [
    pip
    setuptools
    pandas
    requests

    # build:
    # pypi2nix -V 3.6
    # nix-shell requirements.nix -A interpreter

    # try from nix package:
    # nix-shell -p pythonPackages.pip

    jupyterlab
    jupyterlab_launcher

    pytest
    pycodestyle
    black
    pylint
    coverage
  ];
  python-with-my-packages = pkgs.python37.withPackages my-python-packages;
in
{
  environment.systemPackages = with pkgs; [
    pypi2nix
    # python
    # python3
    python-with-my-packages
  ];
}
