{ config, lib, pkgs, ... }:

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
    sessionPath = [
      "$HOME/.npm-packages/bin"
      "$HOME/.npm-packages/lib/node_modules/"
    ];
  };
  gtk = {
    enable = true;
    font.name = "ComicShannsMono Nerd Font 12";
    iconTheme.name = "Tokyonight-Dark";
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    theme = {
      name = "Tokyonight-Dark-B";
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
    userDirs.enable = true;
  };
}

