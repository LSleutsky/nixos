{ config, lib, pkgs, ... }:

{
  imports = [
		./hardware-configuration.nix
		<home-manager/nixos>
    <nixos-hardware/framework/12th-gen-intel>
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "US/Eastern";

  security = {
    rtkit.enable = true;
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

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
      cbonsai
      cmatrix
      coreutils
      curl
      discord
      fd
      figlet
      fortune
      gcc
      git
      gping
      grim
      lolcat
      neo-cowsay
      neofetch
      neovim-nightly
      networkmanager
      nodejs
      onefetch
      pavucontrol
      pipes
      playerctl
      pulsemixer
      sl
      slurp
      swayidle
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
      imports = [ ../home ];
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
      qt = {
        enable = true;
        platformTheme = "gtk";
        style.name = "gtk3";
      };
      xdg = {
        enable = true;
        userDirs.enable = true;
      };
    };
  };
}
