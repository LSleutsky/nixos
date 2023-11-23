{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hyprland
    ./programs
    ./services
  ];

  programs = {
    home-manager.enable = true;
  };

  home = {
    stateVersion = "23.11";
    file = {
      ".npmrc" = {
        enable = true;
        text = ''
          prefix = ''${HOME}/.npm-packages
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
    font.name = "ComicShannsMono Nerd Font 12";
    iconTheme.name = "Catppuccin-Mocha";
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-dark";
      package = pkgs.tokyo-night-gtk;
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

