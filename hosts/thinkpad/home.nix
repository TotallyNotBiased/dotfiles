{
  config,
  pkgs,
  inputs,
  unstable,
  ...
}:

{
  theme.name = "one-dark-pro";

  imports = [
    ../../modules/home/core.nix
    ../../modules/home/shell.nix
    ../../modules/home/firefox.nix
    ../../modules/home/fonts.nix
    inputs.nixvim.homeModules.nixvim
    ../../modules/home/nixvim
    ./noctalia.nix
  ];

  home = {
    pointerCursor = {
      name = "Bibata-Modern-Ice";
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
        tree
        uutils-coreutils
      ])
      ++ (with unstable; [
        antigravity-ide
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
    setSessionVariables = true;
    download = "${config.home.homeDirectory}/downloads";
    pictures = "${config.home.homeDirectory}/img";
    documents = "${config.home.homeDirectory}/docs";
    projects = "${config.home.homeDirectory}/projects";
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
      background_blur = 1;
      foreground = config.theme.colors.base05;
      background = config.theme.colors.base00;
      selection_background = config.theme.colors.base02;
      selection_foreground = config.theme.colors.base00;
      cursor = config.theme.colors.base05;
      color0 = config.theme.colors.base00;
      color8 = config.theme.colors.base03;
      color1 = config.theme.colors.red;
      color9 = config.theme.colors.orange;
      color2 = config.theme.colors.green;
      color10 = config.theme.colors.base01;
      color3 = config.theme.colors.yellow;
      color11 = config.theme.colors.base02;
      color4 = config.theme.colors.blue;
      color12 = config.theme.colors.base04;
      color5 = config.theme.colors.magenta;
      color13 = config.theme.colors.base06;
      color6 = config.theme.colors.cyan;
      color14 = config.theme.colors.violet;
      color7 = config.theme.colors.base05;
      color15 = config.theme.colors.base07;
    };
  };

  home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#thinkpad";
    conf = "cd ~/dotfiles";
  };

  xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/niri/config.kdl";
}
