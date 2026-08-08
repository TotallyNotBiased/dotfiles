{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font =  {
      name = "JetBrains Mono Nerd Font";
      size = 11;
    };
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.75";
      background_blur = 1;
      foreground = config.theme.colors.base05;
      background = config.theme.colors.base00;
      selection_background = config.theme.colors.base02;
      selection_foreground = config.theme.colors.base00;
      cursor = config.theme.colors.base05;
      color0 = config.theme.colors.base00;
      color8 = config.theme.colors.base03;
      color1 = config.theme.colors.red;
      color9 = config.theme.colors.red;
      color2 = config.theme.colors.green;
      color10 = config.theme.colors.green;
      color3 = config.theme.colors.yellow;
      color11 = config.theme.colors.yellow;
      color4 = config.theme.colors.blue;
      color12 = config.theme.colors.blue;
      color5 = config.theme.colors.magenta;
      color13 = config.theme.colors.magenta;
      color6 = config.theme.colors.cyan;
      color14 = config.theme.colors.cyan;
      color7 = config.theme.colors.base05;
      color15 = config.theme.colors.base07;
    };
  };
}
