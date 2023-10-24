{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    settings = {
      background_opacity = "0.75";
      font_family = "ComicShannsMono Nerd Font";
      bold_font = "ComicShannsMono Nerd Font Extra Bold";
      bold_italic = "ComicShannsMono Nerd Font Extra Bold Italic";
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
