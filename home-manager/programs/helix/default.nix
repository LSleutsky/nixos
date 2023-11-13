{ config, lib, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language = [
        {
          name = "javascript";
          formatter = {
            command = "prettier";
          };
          auto-format = true;
        }
        {
          name = "typescript";
          formatter = {
            command = "prettier";
          };
          auto-format = true;
        }
        {
          name = "css";
          auto-format = true;
        }
      ];
    };
    settings = {
      theme = "tokyonight";
      editor = {
        auto-completion = true;
        auto-format = true;
        auto-pairs = true;
        auto-save = true;
        bufferline = "always";
        color-modes = true;
        cursorline = true;
        gutters = [
          "diff"
          "diagnostics"
          "line-numbers"
          "spacer"
        ];
        line-number = "relative";
        middle-click-paste = true;
        mouse = true;
        rulers = [ 100 ];
        shell = [ "zsh" "-c" ];
        true-color = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides = {
          character = "|";
          render = true;
        };
        lsp = {
          enable = true;
          display-messages = true;
          display-inlay-hints = true;
        };
        statusline = {
          left = [
            "mode"
            "spacer"
            "file-name"
            "separator"
            "spacer"
            "version-control"
          ];
          right = [
            "spinner"
            "spacer"
            "position"
            "separator"
            "spacer"
            "position-percentage"
            "spacer"
            "separator"
            "file-encoding"
            "file-type"
          ];
          center = [
            "workspace-diagnostics"    
            "spacer"  
            "diagnostics"
          ];
          mode = {
            insert = "INSERT";
            normal = "NORMAL";
            select = "SELECT";
          };
        };
      };
      keys = {
        normal = {
          q = ":buffer-close";
          D = "kill_to_line_end";
          G = "goto_last_line";
          Q = ":quit!";
          esc = [ "collapse_selection" "keep_primary_selection" ];
          tab = ":bn";
          C-s = ":w";
          S-tab = ":bp";
          space = {
            o = ":config-open";
            r = ":config-reload";
            w = ":w";
          };
        };
      };
    };
  };
}
