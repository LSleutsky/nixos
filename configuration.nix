{ config, lib, inputs, pkgs, ... }:

{
  imports = [
		./hardware-configuration.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "US/Eastern";

  hardware = {
    brillo.enable = true;
  };

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
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
      timeout = 0;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-122b.psf.gz";
    keyMap = "us";
  };

  networking = {
    hostName = "hyprnova";
    networkmanager.enable = true;
  };

  security = {
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
      experimental-features = [ "nix-command" "flakes" ];
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
      flake = "/etc/nixos#hyprnova";
      flags = [ "--update-input" "nixpkgs" ];
    };
    stateVersion = "23.11";
  };

  systemd = {
    services = {
      fprintd = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Type = "simple";
      };
      NetworkManager-wait-online.enable = false;
    };
  };

  services = {
    dbus.enable = true;
    fprintd.enable = true;
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
    autojump.enable = true;
    hyprland.enable = true;
    zsh.enable = true;
    _1password.enable = true;
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

  fonts = {
    packages = with pkgs; [
      fira-code-nerdfont
      fira-code-symbols
      noto-fonts
      noto-fonts-emoji
      (nerdfonts.override {
        fonts = [ "ComicShannsMono" "JetBrainsMono" ];
      })
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      bibata-cursors
      cava
      cargo
      cbonsai
      cliphist
      cmatrix
      coreutils
      curl
      discord
      fd
      figlet
      fortune
      gcc
      gimp
      git
      gnumake
      gping
      grim
      gtk-engine-murrine
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
      nodejs
      onefetch
      papirus-icon-theme
      pipes
      playerctl
      pngquant
      sl
      slurp
      starfetch
      swappy
      swayidle
      tokyo-night-gtk
      tree
      tty-clock
      usbutils
      unzip
      wf-recorder
      wget
      wl-clipboard
      zip
    ];
    variables = {
      BROWSER = "firefox";
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
      extraGroups = [ "wheel" "networkmanager" "video" "input" "docker" "vboxusers" ];
      home = "/home/lush";
    };
  };
}
