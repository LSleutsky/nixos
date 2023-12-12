{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hyprland
    ./programs
    ./services
  ];

  services = {
    blueman-applet.enable = true;
    gnome-keyring.enable = true;
  };

  programs = {
    home-manager.enable = true;
  };

  home = {
    stateVersion = "24.05";
    file = {
      ".npmrc" = {
        enable = true;
        text = ''
          prefix = ''${HOME}/.npm-packages
        '';
      };
      ".zlogin" = {
        enable = true;
        text = ''
          dbus-run-session Hyprland
        '';
      };
    };
    packages = [
      inputs.dipc.packages.${pkgs.system}.default
    ];
    sessionPath = [
      "$HOME/.npm-packages/bin"
      "$HOME/.npm-packages/lib/node_modules/"
    ];
  };
  gtk = {
    enable = true;
    font.name = "RobotoMono Nerd Font 12";
    iconTheme.name = "Catppuccin-Mocha";
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "standard";
        tweaks = ["rimless" "black"];
        variant = "mocha";
      };
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
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
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
}

