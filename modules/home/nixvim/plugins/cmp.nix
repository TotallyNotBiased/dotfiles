{
  programs.nixvim.plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
      mapping = {
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };
    };
  };
}
