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
      experimental-features = [ "nix-command" "flakes" ];
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
      lua
      lua-language-server
      neo-cowsay
      neofetch
      neovim-nightly
      networkmanager
      nodejs
      onefetch
      pavucontrol
      pipes
      playerctl
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
      imports = [
        ../home
      ];
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
          name = "Catppuccin-Mocha-Standard-Mauve-dark";
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
        firefox = {
          enable = true;
          package = pkgs.firefox-devedition;
        };
        helix = {
          enable = true;
          defaultEditor = true;
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
              gutters = [
                "diff"
                "diagnostics"
                "line-numbers"
                "spacer"
              ];
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
                left = [
                  "mode"
                  "spacer"
                  "file-name"
                  "separator"
                  "spacer"
                  "version-control"
                ];
                right = [
                  "spinner"
                  "spacer"
                  "separator"
                  "position"
                  "separator"
                  "spacer"
                  "position-percentage"
                  "spacer"
                  "separator"
                  "file-encoding"
                  "file-type"
                ];
                center = [
                  "workspace-diagnostics"    
                  "spacer"  
                  "diagnostics"
                ];
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
                Q = ":quit!";
                esc = [ "collapse_selection" "keep_primary_selection" ];
                tab = ":bn";
                S-tab = ":bp";
                space = {
                  o = ":config-open";
                  r = ":config-reload";
                  w = ":w";
                };
              };
            };
          };
        };
        neovim = {
          defaultEditor = true;
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
      xdg = {
        enable = true;
        userDirs.enable = true;
      };
    };
  };
}
