{ config, pkgs, ... }:

{
  imports = [
    ./theme.nix
  ];

  home.username = "unbiased";
  home.homeDirectory = "/home/unbiased";
  home.stateVersion = "25.11";

  home.packages = (with pkgs; [
    fastfetch
    gh
    git-filter-repo
    ripgrep
  ]);

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "hi@jerromeyong.com";
        name = "TotallyNotBiased";
        init.defaultBranch = "main";
      };
    };
  };

  programs.home-manager.enable = true;
}
