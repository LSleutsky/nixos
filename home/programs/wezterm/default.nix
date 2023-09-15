{ config, lib, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        automatically_reload_config = true,
        bold_brightens_ansi_colors = true,
        color_scheme = "Tokyo Night",
        default_cursor_style = "BlinkingBar",
        enable_tab_bar = true,
        enable_wayland = true,
        font = wezterm.font("ComicShannsMono Nerd Font"),
        font_size = 12.0,
        front_end = "OpenGL",
        hide_tab_bar_if_only_one_tab = true,
        scrollback_lines = 5000,
        show_tab_index_in_tab_bar = true,
        tab_max_width = 30,
        warn_about_missing_glyphs = false,
        window_close_confirmation = "NeverPrompt",
        keys = {
          {
            key = "d",
            mods = "ALT",
            action = wezterm.action({
              SplitVertical = { domain = "CurrentPaneDomain" }
            })
          },
          {
            key = "d",
            mods = "CTRL|ALT",
            action = wezterm.action({
              SplitHorizontal = { domain = "CurrentPaneDomain" }
            })
          },
          {
            key = "t",
            mods = "CTRL",
            action = wezterm.action({ SpawnTab = "CurrentPaneDomain" })
          },
          {
            key = "w",
            mods = "CTRL|SHIFT",
            action = wezterm.action({
              CloseCurrentPane = { confirm = false }
            })
          },
          {
            key = "x",
            mods = "CTRL",
            action = wezterm.action.ActivateCopyMode
          }, 
          {
            key = "v",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ PasteFrom = "Clipboard" })
          },
          {
            key = "c",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" })
          },
          {
            key = "LeftArrow",
            mods = "CTRL",
            action = wezterm.action({ SendString = "\x1bb" })
          },
          {
            key = "RightArrow",
            mods = "CTRL",
            action = wezterm.action({ SendString = "\x1bf" })
          }
        }
      }
    '';
  };
}
