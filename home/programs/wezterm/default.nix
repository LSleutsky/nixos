{ config, lib, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
        automatically_reload_config = true,
        bold_brightens_ansi_colors = true,
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
        },
        colors = {
          indexed = {[16] = "#f1cf8a", [17] = "#dee1e6"},
          scrollbar_thumb = "#384148",
          split = "#22262e",
          tab_bar = {
            background = "#22262e",
            active_tab = {
              bg_color = "#70a5eb",
	            fg_color = "#b6beca"
            },
            inactive_tab = {
	            bg_color = "#22262e",
	            fg_color = "#b6beca"
	          },
            inactive_tab_hover = {
	            bg_color = "#384148",
	            fg_color = "#b6beca"
	          },
	          new_tab = {
	            bg_color = "#22262e",
	            fg_color = "#b6beca"
	          },
	          new_tab_hover = {
	            bg_color = "#384148",
	            fg_color = "#b6beca",
	            italic = true
	          },
          },
          visual_bell = "#384148",
          compose_cursor = "#f1cf8a",
          foreground = "#b6beca",
          background = "#101419",
          cursor_bg = "#dee1e6",
          cursor_border = "#fafdff",
          cursor_fg = "#22262e",
          selection_bg = "#575268",
          selection_fg = "#d9e0ee",
          ansi = {"#1c252c", "#e05f65", "#78dba9", "#f1cf8a", "#70a5eb", "#c68aee","#74bee9", "#dee1e6"},
          brights = {"#384148", "#fc7b81", "#94f7c5", "#ffeba6", "#8cc1ff", "#e2a6ff", "#90daff", "#b6beca"},
        }
      }
    '';
  };
}
