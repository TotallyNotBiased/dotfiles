{ pkgs, inputs, ... }:
{
  home-manager.users.unbiased = { config, ... }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
    };

    xdg.configFile."noctalia/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/home/unbiased/dotfiles/config/noctalia/settings.json";
  };
}
