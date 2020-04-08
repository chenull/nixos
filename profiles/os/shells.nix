{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    zsh
    oh-my-zsh
  ];

  fonts.fonts = with pkgs; [
    powerline-fonts
  ];

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  programs = {

    bash.enableCompletion = true;
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "agnoster";
        plugins = [
          "git"
          "virtualenv"
        ];
      };
    };

  };

}
