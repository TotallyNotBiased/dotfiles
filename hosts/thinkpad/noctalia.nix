{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    validateConfig = false;
  };

  xdg.configFile."noctalia/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/noctalia/config.toml";
}
