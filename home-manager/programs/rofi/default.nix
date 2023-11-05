{ config, lib, pkgs, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;
    cycle = true;
    font = "ComicShannsMono Nerd Font 12";
    location = "center";
    terminal = "${pkgs.kitty}/bin/kitty";
    plugins = with pkgs; [
      rofi-bluetooth
      rofi-calc
      rofi-emoji
    ];
    extraConfig = {
      modi = "drun,run,filebrowser";
      show-icons = true;
      display-drun = " ";
      display-run = " ";
      display-filebrowser = " ";
      drun-display-format = "{name}";
      window-format = "{w} • {c} • {t}";
    };
    theme = {
      "*" = {
        background = mkLiteral "#180f39";
        background-alt = mkLiteral "#32197D";
        foreground = mkLiteral "#ffffff";
        selected = mkLiteral "#ff00f1";
        active = mkLiteral "#9878ff";
        urgent = mkLiteral "#7d0075";
      };
      "window" = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = false;
        height = mkLiteral "500px";
        width = mkLiteral "1100px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";
        enabled = true;
        border-radius = mkLiteral "15px";
        cursor = "default";
        background-color = mkLiteral "@background";
      };
      "mainbox" = {
        enabled = true;
        spacing = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "horizontal";
        children = map mkLiteral [ "imagebox" "listbox" ];
      };
      "imagebox" = {
        padding = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        background-image = mkLiteral "url(\"~/nixos/home-manager/programs/swww/wallpapers/purple-telescope.png\", height)";
        orientation = mkLiteral "vertical";
        children = map mkLiteral [ "inputbar" "dummy" "mode-switcher" ];
      };
      "listbox" = {
        spacing = mkLiteral "20px";
        padding = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = map mkLiteral [ "message" "listview" ];
      };
      "dummy" = {
        background-color = mkLiteral "transparent";
      };
      "inputbar" = {
        enabled = true;
        spacing = mkLiteral "10px";
        padding = mkLiteral "15px";
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        children = map mkLiteral [ "textbox-prompt-colon" "entry" ];
      };
      "textbox-prompt-colon" = {
        enabled = true;
        expand = false;
        str = " ";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "entry" = {
        enabled = true;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "text";
        placeholder = "Search";
        placeholder-color = mkLiteral "inherit";
      };
      "mode-switcher" = {
        enabled = true;
        spacing = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
      };
      "button" = {
        padding = mkLiteral "15px";
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };
      "button selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };
      "listview" = {
        enabled = true;
        columns = 1;
        lines = 0;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = "default";
      };
      "element" = {
        enabled = true;
        spacing = mkLiteral "15px";
        padding = mkLiteral "8px";
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = mkLiteral "pointer";
      };
      "element normal.normal" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "element normal.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      "element normal.active" = {
        background-color = mkLiteral "@active";
        text-color = mkLiteral "@foreground";
      };
      "element selected.normal" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };
      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      "element selected.active" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      "element-icon" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "32px";
        cursor = mkLiteral "inherit";
      };
      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      "message" = {
        background-color = mkLiteral "transparent";
      };
      "textbox" = {
        padding = mkLiteral "15px";
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      "error-message" = {
        padding = mkLiteral "15px";
        border-radius = mkLiteral "20px";
        background-color = mkLiteral "@background";
        text-color = mkLiteral "@foreground";
      };
    };
  };
}
