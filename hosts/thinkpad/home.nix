{
  config,
  pkgs,
  inputs,
  unstable,
  ...
}:

{
  imports = [
    ../../modules/home/core.nix
    ../../modules/home/shell.nix
    ../../modules/home/firefox.nix
    ../../modules/home/fonts.nix
  ];

  home = {
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    packages =
      (with pkgs; [
        discord
        teams-for-linux
        obsidian
        spotify

        bitwig-studio

        qalculate-gtk
        wl-clipboard
        cliphist
        glib
        gsettings-desktop-schemas
      ])
      ++ (with unstable; [
        antigravity
        krita
      ]);
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    download = "${config.home.homeDirectory}/downloads";
    pictures = "${config.home.homeDirectory}/img";
    documents = "${config.home.homeDirectory}/docs";
    desktop = "${config.home.homeDirectory}";
    music = "${config.home.homeDirectory}";
    publicShare = "${config.home.homeDirectory}";
    templates = "${config.home.homeDirectory}";
    videos = "${config.home.homeDirectory}";
  };

  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.8";
      foreground = config.theme.colors.base05;
      background = config.theme.colors.base00;
      selection_background = config.theme.colors.base02;
      selection_foreground = config.theme.colors.base05;
      cursor = config.theme.colors.base05;
      color0 = config.theme.colors.base01;
      color8 = config.theme.colors.base03;
      color1 = config.theme.colors.red;
      color9 = config.theme.colors.red;
      color2 = config.theme.colors.green;
      color10 = config.theme.colors.green;
      color3 = config.theme.colors.yellow;
      color11 = config.theme.colors.yellow;
      color4 = config.theme.colors.blue;
      color12 = config.theme.colors.blue;
      color5 = config.theme.colors.magenta;
      color13 = config.theme.colors.magenta;
      color6 = config.theme.colors.cyan;
      color14 = config.theme.colors.cyan;
      color7 = config.theme.colors.base05;
      color15 = config.theme.colors.base07;
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos";
      conf = "cd ~/dotfiles";
    };
  };

  xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/niri/config.kdl";
}
