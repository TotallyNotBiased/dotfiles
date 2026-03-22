{  
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    closeIfLastWindow = true; 
    window = {
      settings.width = 30;
      auto_expand_width = true;
    };
  };
}
