{ config, pkgs, inputs, unstable, ... }:

{
  imports = [
    ../../modules/home/core.nix
    ../../modules/home/shell.nix
    inputs.nixvim.homeModules.nixvim
    ../../modules/home/nixvim
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
  };

  home.shellAliases = {
    conf = "cd ~/dotfiles";
    rebuild = "home-manager switch --flake ~/dotfiles#unbiased";
    rebuild-all = "git -C ~/dotfiles add . && home-manager switch --flake ~/dotfiles#unbiased";
  };
}
