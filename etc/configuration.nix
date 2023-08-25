{ config, lib, pkgs, ... }:

{
  imports = [
		./hardware-configuration.nix
		<home-manager/nixos>
    <nixos-hardware/framework/12th-gen-intel>
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  security.rtkit.enable = true;
  time.timeZone = "US/Eastern";

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-old";
    };
    settings = {
      auto-optimise-store = true;
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [
      "iTCO_wdt"
      "sp5100_tco"
    ];
    initrd = {
      kernelModules = [ "i915" ];
    };
    kernelParams = [
      "i915.fastboot=1"
      "loglevel=3"
      "nmi_watchdog=0"
      "nowatchdog"
      "quiet"
      "rd.systemd.show_status=auto"
      "rd.udev.log_priority=3"
      "rootfstype=btrfs"
      "systemd.show_status=auto"
    ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-122b.psf.gz";
    keyMap = "us";
  };

  systemd = {
    services = {
      NetworkManager-wait-online.enable = false;
    };
  };

  networking = {
    hostName = "hyprnova";
    networkmanager.enable = true;
  };

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  system = {
    autoUpgrade.enable = true;
    copySystemConfiguration = true;
    stateVersion = "23.05";
  };

  hardware = {
    brillo.enable = true;
  };

  services = {
    dbus.enable = true;
    fwupd.enable = true;
    openssh.enable = true;
    printing.enable = true;
    thermald.enable = true;
    tlp.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  programs = {
    _1password.enable = true;
    autojump.enable = true;
    hyprland.enable = true;
    zsh.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "lush" ];
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
      }))
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      bibata-cursors
      cava
      cargo
      cmatrix
      coreutils
      curl
      fd
      feh
      figlet
      fortune
      gcc
      git
      gping
      ipfetch
      lolcat
      neo-cowsay
      neofetch
      neovim-nightly
      networkmanager
      nodejs
      onefetch
      pavucontrol
      pipes
      sl
      tree
      tty-clock
      unzip
      wget
      wl-clipboard
      zip
    ];
    variables = {
      NIXOS_OZONE_WL = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
      PAGER = "less";
      SUDO_EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
    };
    pathsToLink = [ "/share/zsh" ];
  };

  fonts = {
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      noto-fonts
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "ComicShannsMono" ]; })
    ];
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.lush = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "docker" ];
      home = "/home/lush";
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.lush = { pkgs, ... }: {
      home.stateVersion = "23.05";
      gtk = {
        enable = true;
        cursorTheme.name = "Bibata-Modern-Classic";
        font.name = "ComicShannsMono Nerd Font 12";
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.catppuccin-papirus-folders;
        };
        theme = {
          name = "Catppuccin-Mocha-Standard-Blue-dark";
          package = pkgs.catppuccin-gtk.override { variant="mocha"; };
        };
        gtk3 = {
          extraConfig = {
            Settings = "gtk-application-prefer-dark-theme=1";
          };
        };
        gtk4 = {
          extraConfig = {
            Settings = "gtk-application-prefer-dark-theme=1";
          };
        };
      };
      programs = {
        alacritty = {
          enable = true;
          settings = {
            env = {
              TERM = "xterm-256color";
            };
            window = {
              dimensions = {
                lines = 40;
                columns = 140;
              };
              padding = {
                x = 0;
                y = 0;
              };
              decorations = "none";
              opacity = 0.75;
            };
            font = {
              normal = {
                family = "ComicShannsMono Nerd Font";
              };
              bold = {
                family = "ComicShannsMono Nerd Font";
              };
              italic = {
                family = "ComicShannsMono Nerd Font";
              };
              size = 11;
            };
            cursor = {
              style = {
                shape = "Beam";
                blinking = "Off";
              };
              vi_mode_style = {
                shape = "Block";
                blinking = "Off";
              };
            };
          };
        };
        autojump = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };
        bat = {
          enable = true;
          extraPackages = with pkgs.bat-extras; [ batman ];
        };
        exa = {
          enable = true;
          enableAliases = true;
          git = true;
          icons = true;
          extraOptions = [
            "--all"
            "--binary"
            "--group-directories-first"
            "--long"
          ];
        };
        firefox = {
          enable = true;
          package = pkgs.firefox-devedition;
        };
        gh = {
          enable = true;
					settings = {
						browser = "firefox";
						editor = "nvim";
						git_protocol = "https";
						pager = "less";
						aliases = {
              al = "auth login";
							rc = "repo create";
							rl = "repo clone";
						};
					};
        };
        git = {
          enable = true;
          delta = {
            enable = true;
            options = {
              commit-decoration-style = "bold box ul #450eff";
              file-decoration-style = "#606018 ul";
              line-numbers = true;
            };
          };
          ignores = [
            ".DS_Store"
            "*.log"
            "node_modules"
            ".npm"
            "Thumbs.db"
            ".yarn"
          ];
          userEmail = "LushSleutsky@gmail.com";
          userName = "LSleutsky";
        };
        helix = {
          enable = true;
          languages = {
            language = [
              {
                name = "javascript";
                formatter = {
                  command = "prettier";
                };
                language-server = {
                  command = "typescript-language-server";
                };
                auto-format = true;
              }
              {
                name = "typescript";
                formatter = {
                  command = "prettier";
                };
                language-server = {
                  command = "typescript-language-server";
                };
                auto-format = true;
              }
              {
                name = "css";
                language-server = {
                  command = "vscode-css-language-server";
                };
                auto-format = true;
              }
            ];
          };
          settings = {
            theme = "catppuccin_mocha";
            editor = {
              auto-completion = true;
              auto-format = true;
              auto-pairs = true;
              auto-save = true;
              bufferline = "always";
              color-modes = true;
              cursorline = true;
              gutters = [ "diff" "diagnostics" "line-numbers" "spacer" ];
              line-number = "relative";
              middle-click-paste = true;
              mouse = true;
              rulers = [ 100 ];
              shell = [ "zsh" "-c" ];
              true-color = true;
              cursor-shape = {
                insert = "bar";
                normal = "block";
                select = "underline";
              };
              indent-guides = {
                character = "|";
                render = true;
              };
              lsp = {
                enable = true;
                display-messages = true;
                display-inlay-hints = true;
              };
              statusline = {
                left = [ "mode" "spacer" "file-name" "separator" "spacer" "version-control" ];
                right = [ "spinner" "spacer" "workspace-diagnostics" "separator" "diagnostics" "position" "file-encoding" "file-type" ];
                mode = {
                  insert = "INSERT";
                  normal = "NORMAL";
                  select = "SELECT";
                };
              };
            };
            keys = {
              normal = {
                q = ":buffer-close";
                D = "kill_to_line_end";
                G = "goto_last_line";
                esc = [ "collapse_selection" "keep_primary_selection" ];
                tab = ":bn";
                S-tab = ":bp";
                space = {
                  c = "toggle_comments";
                  o = ":config-open";
                  r = ":config-reload";
                  w = ":w";
                };
              };
            };
          };
        };
        kitty = {
          enable = true;
          theme = "Catppuccin-Mocha";
          font = {
            name = "ComicShannsMono Nerd Font";
            size = 11;
          };
          shellIntegration = {
            enableZshIntegration = true;
          };
          settings = {
            linux_display_server = "wayland";
            cursor_blink_interval = "0";
            cursor_shape = "beam";
            strip_trailing_spaces = "always";
            tab_bar_style = "fade";
            background_opacity = "0.6";
          };
        };
        neovim = {
          vimdiffAlias = true;
          withNodeJs = true;
        };
        ripgrep = {
          enable = true;
          arguments = [
            "--hidden"
            "--smart-case"
            "--glob=!.git/*"
            "--glob=!{**/node_modules/**, node_modules/**, node_modules}"
            "--glob=!package-lock.json"
          ];
        };
        starship = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            format = "$directory$git_branch$git_status$docker_context$character";
            right_format = "$nodejs";
            add_newline = true;
            character = {
              success_symbol = "[](#a6e3a1 bold)";
              error_symbol = "[](#f38ba8)";
              vicmd_symbol = "[](#f9e2af)";
            };
            directory = {
              format = "[]($style)[ ](bg:#181825 fg:#b4befe)[$path](bg:#181825 fg:#cdd6f4 bold)[ ]($style)";
              style = "bg:none fg:#181825";
              truncation_length = 3;
              truncate_to_repo=false;
            };
            docker_context = {
              symbol = "  ";
              style = "blue bold";
              format = "via [$symbol$context]($style) ";
              only_with_files = true;
              disabled = false;
              detect_extensions = [];
              detect_files = [
                "docker-compose.yml"
                "docker-compose.yaml"
                "Dockerfile"
              ];
              detect_folders = [ "docker" ];
            };
            git_branch = {
              format = "[]($style)[[ ](bg:#181825 fg:#74c7ec bold)$branch](bg:#181825 fg:#74c7ec)[ ]($style)";
              style = "bg:none fg:#181825";
            };
            git_status = {
              format = "([$all_status$ahead_behind]($style) )";
              style = "bg:none fg:#f38ba8";
              stashed = "\$";
              ahead = "⇡";
              behind = "⇣";
              up_to_date = "";
              diverged = "⇕";
              conflicted = "=";
              deleted = "✘";
              renamed = "»";
              modified = "!";
              staged = "+";
              untracked = "?";
              ignore_submodules = false;
              disabled = false;
            };
            line_break = {
              disabled = false;
            };
            nodejs = {
              format = " [$symbol($version )]($style)";
              symbol = " ";
              style = "bold green";
              disabled = false;
              not_capable_style = "bold red";
              detect_extensions = [
                "js"
                "jsx"
                "mjs"
                "cjs"
                "ts"
                "tsx"
                "mts"
                "cts"
              ];
              detect_files = [
                "package.json"
                ".node-version"
                ".nvmrc"
                ".yarnrc"
                ".npmrc"
              ];
              detect_folders = [
                ".nvm"
                "js"
                "node_modules"
              ];
            };
          };
        };
        waybar = {
          enable = true;
          systemd.enable = true;
          package = pkgs.waybar.overrideAttrs (oldAttrs: {
            mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          });
          settings = {
            mainBar = {
              position = "top";
              layer = "top";
              fixed-center = true;
              modules-left = [
                "temperature"
                "cpu"
                "memory"
              ];
              modules-center = [ "wlr/workspaces" ];
              modules-right = [
                "bluetooth"
                "network"
                "backlight"
                "pulseaudio"
                "battery"
                "clock"
                "idle_inhibitor"
              ];
            };
          };
        };
        wezterm = {
          enable = true;
          enableZshIntegration = true;
          extraConfig = ''
            return {
              automatically_reload_config = true,
              bold_brightens_ansi_colors = true,
              color_scheme = "Catppuccin Mocha",
              default_cursor_style = "BlinkingBar",
              enable_tab_bar = true,
              enable_wayland = true,
              font = wezterm.font("ComicShannsMono Nerd Font"),
              font_size = 12.0,
              front_end = "OpenGL",
              hide_tab_bar_if_only_one_tab = true,
              scrollback_lines = 5000,
              show_tab_index_in_tab_bar = true,
              tab_max_width = 30,
              warn_about_missing_glyphs = false,
              window_close_confirmation = "NeverPrompt",
              keys = {
                {
                  key = "n",
                  mods = "CTRL",
                  action = wezterm.action({
                    SplitHorizontal = { domain = "CurrentPaneDomain" }
                  })
                },
                {
                  key = "n",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({
                    SplitVertical = { domain = "CurrentPaneDomain" }
                  })
                },
                {
                  key = "t",
                  mods = "CTRL",
                  action = wezterm.action({ SpawnTab = "CurrentPaneDomain" })
                },
                {
                  key = "w",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({
                    CloseCurrentPane = { confirm = false }
                  })
                },
                {
                  key = "x",
                  mods = "CTRL",
                  action = wezterm.action.ActivateCopyMode
                }, 
                {
                  key = "v",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({ PasteFrom = "Clipboard" })
                },
                {
                  key = "c",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" })
                },
                {
                  key = "LeftArrow",
                  mods = "CTRL",
                  action = wezterm.action({ SendString = "\x1bb" })
                },
                {
                  key = "RightArrow",
                  mods = "CTRL",
                  action = wezterm.action({ SendString = "\x1bf" })
                }
              }
            }
          '';
        };
        zsh = {
          enable = true;
          autocd = true;
          enableAutosuggestions = true;
          enableCompletion = true;
          syntaxHighlighting = {
            enable = true;
          };
          shellAliases = {
            ".." = "cd ../";
            "..." = "cd ../../";
            "...." = "cd ../../../";
            "....." = "cd ../../../../";
            "......" = "cd ../../../../../";
            "......." = "cd ../../../../../../";
            "........" = "cd ../../../../../../../";
            "........." = "cd ../../../../../../../../";
            ".........." = "cd ../../../../../../../../../";
            batt = "bat /sys/class/power_supply/BAT1/capacity";
            clock = "tty-clock -bcsC4 -f %a,\\ %b\\ %d";
            config = "sudo -Es nvim /etc/nixos/configuration.nix";
            df = "df -h";
            free = "free -mth";
            garbage = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
            gsb = "git status -sb";
            grep = "grep --color=auto";
            history = "history -i";
            lsblk = "lsblk -f";
            man = "batman";
            mkdir = "mkdir -p";
            n = "nvim";
            pow = "sudo shutdown now";
            reb = "sudo reboot now";
            sn = "sudo nvim";
            switch = "sudo nixos-rebuild switch";
            tree = "tree -ad --gitignore -C -L 2";
            update = "sudo nix-channel --update";
          };
          initExtra = ''
            setopt always_to_end
            setopt append_history
            setopt auto_list
            setopt auto_menu
            setopt auto_pushd
            setopt complete_in_word
            setopt extended_history
            setopt hist_find_no_dups
            setopt hist_ignore_dups
            setopt hist_ignore_all_dups
            setopt hist_reduce_blanks
            setopt hist_save_no_dups
            setopt inc_append_history
            setopt menu_complete

            _comp_options+=(globdots)

            zle -N up-line-or-beginning-search
            zle -N down-line-or-beginning-search
            zle -N zsh-backward-kill-word

            zstyle ':completion:*:*:*:*:*' menu select
            zstyle ':completion:*' special-dirs true
            zstyle ':completion:*' list-colors ""
            zstyle ':completion::complete:*' gain-privileges 1

            if [[ "$CASE_SENSITIVE" = true ]]; then
              zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
            else
              if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
                zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
              else
                zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
              fi
            fi

            unset CASE_SENSITIVE HYPHEN_INSENSITIVE

            bindkey -e
            bindkey "^[[3~" delete-char
            bindkey "^[[5~" beginning-of-buffer-or-history
            bindkey "^[[6~" end-of-buffer-or-history
            bindkey "^[[H" beginning-of-line
            bindkey "^[[F" end-of-line
            bindkey "^[[1;5C" forward-word
            bindkey "^[[1;5D" backward-word
            bindkey "^[[A" up-line-or-beginning-search
            bindkey "^[[B" down-line-or-beginning-search
            bindkey '^w' zsh-backward-kill-word
          '';
          initExtraBeforeCompInit = ''
            autoload -U up-line-or-beginning-search
            autoload -U down-line-or-beginning-search
          '';
          initExtraFirst = ''
            zsh-backward-kill-word () {
              local WORDCHARS=""
                zle -f kill
                zle backward-kill-word
            }
          '';
        };
      };
      qt = {
        enable = true;
        platformTheme = "gtk";
        style.name = "gtk2";
      };
      services = {
        playerctld.enable = true;
        dunst = {
          enable = true;
        };
      };
      wayland.windowManager.hyprland = {
        enable = true;
        systemdIntegration = true;
        settings = {
          "$mainMod" = "SUPER";
          "$mainModShift" = "SUPERSHIFT";
          monitor = [
            "eDP-1,2250x1504@60,0x0,1"
          ];
          exec-once = [
            "hyprctl setcursor Bibata-Modern-Classic 24"
          ];
          input = {
            repeat_rate = 50;
            repeat_delay = 240;
            touchpad = {
              clickfinger_behavior = 1;
              disable_while_typing = 1;
              middle_button_emulation = 0;
              natural_scroll = 1;
              tap-to-click = 1;
            };
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_min_speed_to_force = 5;
          };
          general = {
            layout = "dwindle";
            sensitivity = 2;
            gaps_in = 11.8;
            gaps_out = 15.5;
            border_size = 4;
            "col.active_border" = "0xff313244";
            "col.inactive_border" = "0x66333333";
            apply_sens_to_raw = 0;
          };
          decoration = {
            rounding = 20;
            drop_shadow = true;
            shadow_range = 30;
            "col.shadow_inactive" = "0x50000000";
            blur = {
              enabled = true;
              size = 13;
              passes = 3;
              new_optimizations = true;
            };
          };
          animations = {
            enabled = 1;
            bezier = "overshot,0.13,0.99,0.29,1.1";
            animation = [
              "windows,1,4,overshot,slide"
              "fade,1,10,default"
              "workspaces,1,8.8,overshot,slide"
              "border,1,14,default"
            ];
          };
          dwindle = {
            pseudotile = 1;
            force_split = 0;
            no_gaps_when_only = false;
          };
          master = {
            new_on_top = true;
            no_gaps_when_only = false;
          };
          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            mouse_move_enables_dpms = true;
            vfr = true;
            hide_cursor_on_touch = true;
          };
          bind = [
            "$mainMod, B, exec, firefox"
            "$mainMod, F, fullscreen, 1"
            "$mainMod, P, pseudo"
            "$mainMod, Q, killactive"
            "$mainMod, T, togglefloating"
            "$mainMod, RETURN, exec, wezterm" 
            "$mainModShift, F, fullscreen, 0"
            "$mainModShift, Q, exit"
          ];
          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];
          windowrule = [
            "tile,title:^(wezterm)$"
          ];
        };
      };
      xdg = {
        enable = true;
        userDirs.enable = true;
      };
    };
  };
}
