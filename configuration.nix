{ config, lib, inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./scripts
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "US/Eastern";

  hardware = {
    brillo.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    logitech = {
      wireless = {
        enable = true;
        enableGraphical = true;
      };
    };
  };

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/nix".options = ["compress=zstd" "noatime"];
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    blacklistedKernelModules = ["iTCO_wdt" "sp5100_tco"];
    initrd = {
      kernelModules = ["i915"];
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
      timeout = 0;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  console = {
    earlySetup = true;
    packages = with pkgs; [terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-122b.psf.gz";
    keyMap = "us";
  };

  networking = {
    hostName = "hyprnova";
    networkmanager.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-old";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  system = {
    autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "--no-write-lock-file"
        "-L"
      ];
      dates = "daily";
    };
    stateVersion = "24.05";
  };

  systemd = {
    services = {
      fprintd = {
        wantedBy = ["multi-user.target"];
        serviceConfig.Type = "simple";
      };
      NetworkManager-wait-online.enable = false;
    };
    user.services = {
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 1;
        };
      };
    };
  };

  services = {
    blueman.enable = true;
    dbus.enable = true;
    fprintd.enable = true;
    fwupd.enable = true;
    openssh.enable = true;
    printing.enable = true;
    thermald.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    tlp = {
      enable = true;
      settings = {
        RESTORE_DEVICE_STATE_ON_STARTUP = 1;
      };
    };
  };

  programs = {
    autojump.enable = true;
    hyprland.enable = true;
    zsh.enable = true;
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["lush"];
    };
  };

  fonts = {
    packages = with pkgs; [
      fira-code-nerdfont
      fira-code-symbols
      noto-fonts
      noto-fonts-emoji
      (nerdfonts.override {
        fonts = ["ComicShannsMono" "JetBrainsMono" "RobotoMono"];
      })
    ];
  };

  xdg = {
    autostart.enable = true;
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["zathura.desktop" "firefox.desktop"];
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };
    portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      bibata-cursors
      catppuccin-gtk
      cava
      cargo
      cbonsai
      cliphist
      cmatrix
      coreutils
      cpufetch
      curl
      discord
      dropbox-cli
      fd
      figlet
      fortune
      gcc
      gimp
      git
      glow
      gnumake
      google-chrome
      gping
      grim
      gtk-engine-murrine
      hugo
      hyprpicker
      imagemagick
      inxi
      lolcat
      lshw
      neo-cowsay
      neofetch
      neovim-nightly
      networkmanager
      nitch
      nodePackages_latest.nodejs
      onefetch
      papirus-icon-theme
      pipes
      playerctl
      pngquant
      polkit
      polkit_gnome
      python3
      ramfetch
      sassc
      sl
      slurp
      starfetch
      swappy
      swayidle
      tree
      tty-clock
      typescript
      usbutils
      unzip
      wdisplays
      wf-recorder
      wget
      wl-clipboard
      zip
      zk
    ];
    variables = {
      BROWSER = "firefox";
      DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
      EDITOR = "nvim";
      GTK_THEME = "Catppuccin-Mocha-Standard-Blue-Dark";
      NIXOS_OZONE_WL = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
      NODE_PATH = "$HOME/.npm-packages/lib/node_modules/";
      PAGER = "less";
      SUDO_EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
    };
    pathsToLink = [ "/share/zsh" ];
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.lush = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "input"
        "docker"
        "vboxusers"
      ];
      home = "/home/lush";
    };
  };
}
