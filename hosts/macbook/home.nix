{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home/core.nix
    ../../modules/home/shell.nix
    ../../modules/home/firefox.nix
    ../../modules/home/fonts.nix
  ];

  home.shellAliases = {
    conf = "cd ~/dotfiles";
    rebuild = "darwin-rebuild switch --flake ~/dotfiles#macbook";
    rebuild-all = "git -C ~/dotfiles add . && darwin-rebuild switch --flake ~/dotfiles#macbook";
  };
}
