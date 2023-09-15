{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [ rofi ];
    file.".config/rofi/config.rasi".text = ''
      // -- Config
      configuration {
        modi: "drun,filebrowser,window,run";
        show-icons: true;
        display-drun: " ";
        display-run: " ";
        display-filebrowser: " ";
        display-window: " ";
        drun-display-format: "{name}";
        window-format: "{w}{t}";
        font: "ComicShannsMono Nerd Font";
        icon-theme: "Tokyonight-Dark";
      }

      @theme "~/nixos/home/programs/rofi/tokyonight.rasi"

      // -- Main
      window {
        height: 590px;
        width: 1140px;
        transparency: "real";
        fullscreen: false;
        enabled: true;
        cursor: "default";
        spacing: 0px;
        padding: 0px;
        border: 2px;
        border-radius: 40px;
        border-color: @alternate-normal-background;
        background-color: transparent;
        background-image: url("~/nixos/home/programs/swww/wallpapers/glowing-black-hole.png", height);
      }
      mainbox {
        enabled: true;
        spacing: 0px;
        orientation: horizontal;
        children: [ "inputbar", "listbox" ];
        background-color: transparent;
        background-image: url("~/nixos/home/programs/swww/wallpapers/glowing-black-hole.png", height);
      }

      // -- Inputs
      inputbar {
        enabled: true;
        width: 25%;
        children: [ "mode-switcher", "entry" ];
        background-color: transparent;
        background-image: url("~/nixos/home/programs/swww/wallpapers/glowing-black-hole.png", height);
      }
      entry {
        enabled: false;
      }

      // -- Modes
      mode-switcher {
        orientation: vertical;
        enabled: true;
        spacing: 0px;
        width: 68px;
        padding: 160px 10px;
        spacing: 25px;
        background-color: transparent;
        background-image: url("~/nixos/home/programs/swww/wallpapers/glowing-black-hole.png", height);
      }
      button {
        cursor: pointer;
        border-radius: 50px;
        background-color: @background;
        text-color: @foreground;
      }
      button selected {
        background-color: @foreground;
        text-color: @foreground;
      }

      // -- Lists
      listbox {
        spacing: 10px;
        padding: 30px;
        children: [ "listview" ];
        background-color: @background;
      }
      listview {
        enabled: true;
        columns: 1;
        cycle: true;
        dynamic: true;
        scrollbar: false;
        layout: vertical;
        reverse: false;
        fixed-height: true;
        fixed-columns: true;
        cursor: "default";
        background-color: transparent;
        text-color: @foreground;
      }

      // -- Elements
      element {
        enabled: true;
        spacing: 30px;
        padding: 8px;
        border-radius: 20px;
        cursor: pointer;
        background-color: transparent;
        text-color: @foreground;
      }
      element normal.normal {
        background-color: transparent;
        text-color: @normal-foreground;
      }
      element normal.urgent {
        background-color: @urgent-background;
        text-color: @urgent-foreground;
      }
      element normal.active {
        background-color: @active-background;
        text-color: @active-foreground;
      }
      element selected.normal {
        background-color: @selected-normal-background;
        text-color: @selected-normal-foreground;
      }
      element selected.urgent {
        background-color: @selected-urgent-background;
        text-color: @selected-urgent-foreground;
      }
      element selected.active {
        background-color: @selected-active-background;
        text-color: @selected-active-foreground;
      }
      element-icon {
        size: 48px;
        cursor: inherit;
        background-color: transparent;
        text-color: inherit;
      }
      element-text {
        vertical-align: 0.5;
        horizontal-align: 0.0;
        cursor: inherit;
        background-color: transparent;
        text-color: inherit;
      }
    '';
  };
}