{
  imports = [
    ./lsp.nix
    ./cmp.nix
    ./neo-tree.nix
    ./colorizer.nix
  ];

  programs.nixvim.plugins = {
    lualine.enable = true;
    telescope.enable = true;
    web-devicons.enable = true;
    treesitter.enable = true;
    lsp-lines.enable = true;
  };
}
