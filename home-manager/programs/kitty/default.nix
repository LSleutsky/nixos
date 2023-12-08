{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    settings = {
      background_opacity = "0.75";
      font_family = "RobotoMono Nerd Font";
      bold_font = "RobotoMono Nerd Font Extra Bold";
      bold_italic = "RobotoMono Nerd Font Extra Bold Italic";
      font_size = "12";
      cursor_blink_interval = 0;
      cursor_shape = "beam";
      linux_display_server = "wayland";
      scrollback_lines = 10000;
      strip_trailing_spaces = "always";
      tab_bar_style = "fade";
      url_color = "#519aba";
      wayland_titlebar_color = "background";
    };
  };
}
