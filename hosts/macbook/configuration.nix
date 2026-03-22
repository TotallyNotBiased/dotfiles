{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.vim
  ];

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;  # default macos shell, required for nix-darwin hooks even if using bash
  programs.bash.enable = true;

  # create /etc/bashrc that loads the nix-darwin environment.
  environment.shells = [
    pkgs.bashInteractive
    pkgs.zsh
  ];

  users.users.unbiased = {
    name = "unbiased";
    home = "/Users/unbiased";
  };

  system.stateVersion = 5;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
