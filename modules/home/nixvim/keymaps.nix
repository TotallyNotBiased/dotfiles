{
  programs.nixvim.globals.mapleader = " ";

  programs.nixvim.keymaps = [
      # General keymaps
      {
		key = "<C-;>";
		action = "i<CR><Esc>";
		options.desc = "Break line at cursor position in Normal mode";
      }
      {
                mode = "n";
		key = "<C-s>";
		action = "<cmd>w<CR>";
                options.desc = "Save while in Normal mode";
      }
      # LSP keymaps
      {
		key = "<leader>h";
		action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))<CR>";
		options.desc = "Toggle Inlay Hints";
      }
      # Plugin keymaps
      {
                mode = "n";
		key = "<leader>e";
		action = "<cmd>lua vim.diagnostic.open_float()<CR>";
		options.desc = "Open diagnostic float";
      }
      {
		key = "<leader>ff";
		action = "<cmd>Telescope find_files<CR>";
		options.desc = "Telescope Finder";
      }
      {
		key = "<leader>fd";
		action = "<cmd>Telescope git_files<CR>";
		options.desc = "Telescope Finder (Git)";
      }
      {
		key = "<leader>lg";
		action = "<cmd>Telescope live_grep<CR>";
		options.desc = "Telescope Live Grep";
      }
    ];
}
