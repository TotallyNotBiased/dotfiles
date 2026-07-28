{ config, pkgs, ... }:


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

      highlight = {
        TelescopePromptBorder.link = "TelescopeBorder";
        TelescopePromptNormal.link = "TelescopeNormal";
        TelescopePromptPrefix.link = "TelescopeNormal";
        TelescopePromptTitle = {
          fg = config.theme.colors.red;
          bold = true;
        };
        TelescopePreviewTitle = {
          fg = config.theme.colors.green;
          bold = true;
        };
        TelescopeResultsTitle = {
          fg = config.theme.colors.cyan;
          bold = true;
        };
      };

      colorschemes.base16 = {
        enable = true;
        colorscheme = {
          base00 = "${config.theme.colors.base00}";
          base01 = "${config.theme.colors.base01}";
          base02 = "${config.theme.colors.base02}";
          base03 = "${config.theme.colors.base03}";
          base04 = "${config.theme.colors.base04}";
          base05 = "${config.theme.colors.base05}";
          base06 = "${config.theme.colors.base06}";
          base07 = "${config.theme.colors.base07}";
          base08 = "${config.theme.colors.red}";
          base09 = "${config.theme.colors.orange}";
          base0A = "${config.theme.colors.yellow}";
          base0B = "${config.theme.colors.green}";
          base0C = "${config.theme.colors.cyan}";
          base0D = "${config.theme.colors.blue}";
          base0E = "${config.theme.colors.magenta}";
          base0F = "${config.theme.colors.violet}";
        };
      };
      version.enableNixpkgsReleaseCheck = false;
  };
}

