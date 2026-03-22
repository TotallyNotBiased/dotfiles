{ pkgs, ... }:


{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];

  # entry point for nixvim

  programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;

      colorschemes.catppuccin.enable = true;
      web-devicons.enable = true;
  };
}

