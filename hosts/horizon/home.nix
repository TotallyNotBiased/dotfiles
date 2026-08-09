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
    ../../modules/home/kitty.nix
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
        slurp
        ffmpeg
        gpu-screen-recorder
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

  home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#horizon";
    conf = "cd ~/dotfiles";
  };

  xdg.configFile."niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/niri/config.kdl";
}
