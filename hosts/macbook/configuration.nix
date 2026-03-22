{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.vim
  ];

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  # Setup shells
  programs.zsh.enable = true;  # default macos shell, required for nix-darwin hooks even if using bash
  programs.bash.enable = true;

  # Create /etc/bashrc that loads the nix-darwin environment.
  environment.shells = [
    pkgs.bashInteractive
    pkgs.zsh
  ];

  # Set default shell for your user
  users.users.unbiased = {
    name = "unbiased";
    home = "/Users/unbiased";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
