{ pkgs, inputs, ... }:
{
  home-manager.users.unbiased = { config, ... }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      validateConfig = false;
    };

    xdg.configFile."noctalia/config.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/unbiased/dotfiles/config/noctalia/config.toml";
  };
}
