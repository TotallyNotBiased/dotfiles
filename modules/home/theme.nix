{ config, lib, ... }:

let
  palettes = {
    gotham = {
      base00 = "#0c1014";
      base01 = "#11151c";
      base02 = "#091f2e";
      base03 = "#0a3749";
      base04 = "#1e6479";
      base05 = "#599cab";
      base06 = "#99d1ce";
      base07 = "#d3ebe9";
      red     = "#c23127";
      orange  = "#d26937";
      yellow  = "#edb443";
      green   = "#2aa889";
      cyan    = "#33859E";
      blue    = "#195466";
      magenta = "#888ca6";
      violet  = "#4e5166";
    };

    coral_navy = {
      base00 = "#071f60";
      base01 = "#09287a";
      base02 = "#5677bf"; # selection
      base03 = "#5677bf"; # comments
      base04 = "#a4cdec"; # dark fg
      base05 = "#a4cdec"; # default fg
      base06 = "#fbb687"; # light fg
      base07 = "#fb9259"; # light bg
      red     = "#ff5555";
      orange  = "#fb9259";
      yellow  = "#fbb687";
      green   = "#a4cdec";
      cyan    = "#8be9fd";
      blue    = "#5677bf";
      magenta = "#ff79c6";
      violet  = "#bd93f9";
    };
  };
in
{
  options.theme = {
    name = lib.mkOption {
      # automatically validates that the theme string exists in `palettes`
      type = lib.types.enum (builtins.attrNames palettes);
      default = "gotham"; 
      description = "color palette for the system";
    };
    
    colors = {
      base00 = lib.mkOption { type = lib.types.str; };
      base01 = lib.mkOption { type = lib.types.str; };
      base02 = lib.mkOption { type = lib.types.str; };
      base03 = lib.mkOption { type = lib.types.str; };
      base04 = lib.mkOption { type = lib.types.str; };
      base05 = lib.mkOption { type = lib.types.str; };
      base06 = lib.mkOption { type = lib.types.str; };
      base07 = lib.mkOption { type = lib.types.str; };
      red     = lib.mkOption { type = lib.types.str; };
      orange  = lib.mkOption { type = lib.types.str; };
      yellow  = lib.mkOption { type = lib.types.str; };
      green   = lib.mkOption { type = lib.types.str; };
      cyan    = lib.mkOption { type = lib.types.str; };
      blue    = lib.mkOption { type = lib.types.str; };
      magenta = lib.mkOption { type = lib.types.str; };
      violet  = lib.mkOption { type = lib.types.str; };
    };
  };

  config = {
    theme.colors = palettes.${config.theme.name};
  };
}
