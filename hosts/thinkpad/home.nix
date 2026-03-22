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
        swaylock
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
  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#nixos";
      conf = "cd ~/dotfiles";
    };
    profileExtra = ''
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          exec niri
        fi
      # '';
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono:size=11";
        icon-theme = "Papirus-Dark";

        width = 45;
        lines = 10;
        "line-height" = 25;
        "horizontal-pad" = 25;
        "vertical-pad" = 25;
        "inner-pad" = 10;

        prompt = "'❯   '";
        layer = "top";
      };

      colors = {
        # rrggbbaa
        background = "1e1e2edd"; # purple-grey with alpha
        text = "cdd6f4ff"; # off-white blue
        match = "f5c2e7ff"; # pink

        selection = "cba6f7ff"; # mauve accent
        "selection-text" = "1e1e2eff"; # dark text on selection
        "selection-match" = "1e1e2eff";

        border = "cba6f7ff"; # mauve border
      };

      border = {
        width = 2;
        radius = 10;
      };
    };
  };
}
