{
  programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = true;

    keymaps.lspBuf = {
      gd = "definition";
      K = "hover";
      "<leader>ca" = "code_action";
      "<leader>rn" = "rename";
    };

    servers = {
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;

        settings = {
          inlayHints = {
            bindingModeHints = { enable = true; };
            typeHints = {
              enable = true;
              hideClosureInitialization = false;
              hideNamedConstructor = false;
            };
            
            chainingHints = { enable = true; };
            parameterHints = { enable = true; };
            closureReturnTypeHints = { enable = "always"; };
          };
        };
      };

      clangd = {
        enable = true;
      };

      nil_ls.enable = true;
    };
  };
}
