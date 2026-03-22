{
  imports = [
    ./lsp.nix
    ./cmp.nix
    ./neo-tree.nix
    ./toggleterm.nix
  ];

  programs.nixvim.plugins = {
    lualine.enable = true;
    telescope.enable = true;
    web-devicons.enable = true;
    treesitter.enable = true;
    lsp-lines.enable = true;
  };
}
