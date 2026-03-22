{  
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    close_if_last_window = true; 
    window = {
      settings.width = 30;
      auto_expand_width = true;
    };
  };
}
