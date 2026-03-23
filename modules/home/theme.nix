{ config, lib, ... }:

{
  options.theme = {
    # Gotham Base16 colour scheme: https://github.com/whatyouhide/vim-gotham.git
    colors = {
      base00 = lib.mkOption { type = lib.types.str; default = "#0c1014"; };
      base01 = lib.mkOption { type = lib.types.str; default = "#11151c"; };
      base02 = lib.mkOption { type = lib.types.str; default = "#091f2e"; };
      base03 = lib.mkOption { type = lib.types.str; default = "#0a3749"; };
      base04 = lib.mkOption { type = lib.types.str; default = "#1e6479"; };
      base05 = lib.mkOption { type = lib.types.str; default = "#599cab"; };
      base06 = lib.mkOption { type = lib.types.str; default = "#99d1ce"; };
      base07 = lib.mkOption { type = lib.types.str; default = "#d3ebe9"; };

      red     = lib.mkOption { type = lib.types.str; default = "#c23127"; };
      orange  = lib.mkOption { type = lib.types.str; default = "#d26937"; };
      yellow  = lib.mkOption { type = lib.types.str; default = "#edb443"; };
      green   = lib.mkOption { type = lib.types.str; default = "#2aa889"; };
      cyan    = lib.mkOption { type = lib.types.str; default = "#33859E"; };
      blue    = lib.mkOption { type = lib.types.str; default = "#195466"; };
      magenta = lib.mkOption { type = lib.types.str; default = "#888ca6"; };
      violet  = lib.mkOption { type = lib.types.str; default = "#4e5166"; };
    };
  };
}
