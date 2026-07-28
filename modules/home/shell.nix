{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = ''
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      function mkflake() {
        if [ -z "$1" ]; then
          echo "Usage: mkflake <template>"
          return 1 
        fi
        nix flake init -t ~/dotfiles#"$1" && \
        echo "use flake" > .envrc && \
        direnv allow
      }
    '';
  };

  programs.yazi = {
    shellWrapperName = "yy";
    enable = true;
    enableBashIntegration = true;
    theme = {
      mgr = {
        cwd = { fg = config.theme.colors.cyan; };
        hovered = { fg = config.theme.colors.base00; bg = config.theme.colors.blue; };
        tab_active = { fg = config.theme.colors.base00; bg = config.theme.colors.blue; };
        tab_inactive = { fg = config.theme.colors.base05; bg = config.theme.colors.base01; };
        border_style = { fg = config.theme.colors.base03; };
      };
      status = {
        separator_style = { fg = config.theme.colors.base01; bg = config.theme.colors.base01; };
        mode_normal = { fg = config.theme.colors.base00; bg = config.theme.colors.blue; bold = true; };
        mode_select = { fg = config.theme.colors.base00; bg = config.theme.colors.green; bold = true; };
        mode_unset = { fg = config.theme.colors.base00; bg = config.theme.colors.magenta; bold = true; };
      };
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      format = "$username$directory$git_branch$git_status$nix_shell$character";

      username = {
        show_always = true;
        style_user = "bg:${config.theme.colors.magenta} fg:${config.theme.colors.base00}";
        style_root = "bg:${config.theme.colors.red} fg:${config.theme.colors.base00}";
        format = "[ $user ]($style)[](bg:${config.theme.colors.base01} fg:${config.theme.colors.magenta})";
      };

      directory = {
        style = "bg:${config.theme.colors.base01} fg:${config.theme.colors.base05}";
        format = "[ $path ]($style)[](fg:${config.theme.colors.base01}) ";
      };

      git_branch = {
        symbol = "";
        style = "fg:${config.theme.colors.magenta}";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "fg:${config.theme.colors.magenta}";
        format = "[($all_status$ahead_behind )]($style) ";
      };

      nix_shell = {
        disabled = false;
        symbol = "";
        style = "bg:${config.theme.colors.blue} fg:${config.theme.colors.base00}";
        format = "[ $symbol $name ]($style) ";
      };

      character = {
        success_symbol = " [➜](bold green)";
        error_symbol = " [➜](bold red)";
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-processes 'nvim yazi'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -g status-left-length 30
      set -ag terminal-overrides ",xterm-256color:RGB"

      set -g status-position bottom
      set -g status-style "bg=${config.theme.colors.base00},fg=${config.theme.colors.base05}"
      set -g window-status-current-style "bg=${config.theme.colors.magenta},fg=${config.theme.colors.base00},bold"
      set -g window-status-style "bg=${config.theme.colors.base01},fg=${config.theme.colors.base05}"
      set -g pane-border-style "fg=${config.theme.colors.base01}"
      set -g pane-active-border-style "fg=${config.theme.colors.magenta}"
      set -g message-style "bg=${config.theme.colors.magenta},fg=${config.theme.colors.base00}"
      
      set -g status-left "#[bg=${config.theme.colors.blue},fg=${config.theme.colors.base00},bold] #S "
      set -g status-right "#[bg=${config.theme.colors.base01},fg=${config.theme.colors.base05}] %H:%M "
      set -g window-status-format " #I:#W "
      set -g window-status-current-format " #I:#W "

      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      bind c new-window -c "#{pane_current_path}"

      bind-key j switch-client -n
      bind-key k switch-client -p

      # Visual selection and yank like vim in copy mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    '';
  };
}
