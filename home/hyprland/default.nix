{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    settings = {
      "$mainMod" = "SUPER";
      "$mainModShift" = "SUPERSHIFT";
      monitor = [
        "eDP-1,2250x1504@60,0x0,1"
      ];
      exec-once = [
        "hyprctl setcursor Bibata-Modern-Classic 24"
      ];
      input = {
        repeat_rate = 50;
        repeat_delay = 240;
        touchpad = {
          clickfinger_behavior = 1;
          disable_while_typing = 1;
          middle_button_emulation = 0;
          natural_scroll = 1;
          tap-to-click = 1;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_speed_to_force = 5;
      };
      general = {
        layout = "dwindle";
        sensitivity = 2;
        gaps_in = 11.8;
        gaps_out = 15.5;
        border_size = 4;
        "col.active_border" = "0xff313244";
        "col.inactive_border" = "0x66333333";
        apply_sens_to_raw = 0;
      };
      decoration = {
        rounding = 20;
        drop_shadow = true;
        shadow_range = 30;
        "col.shadow_inactive" = "0x50000000";
        blur = {
          enabled = true;
          size = 13;
          passes = 3;
          new_optimizations = true;
        };
      };
      animations = {
        enabled = 1;
        bezier = "overshot,0.13,0.99,0.29,1.1";
        animation = [
          "windows,1,4,overshot,slide"
          "fade,1,10,default"
          "workspaces,1,8.8,overshot,slide"
          "border,1,14,default"
        ];
      };
      dwindle = {
        pseudotile = 1;
        force_split = 0;
        no_gaps_when_only = false;
      };
      master = {
        new_on_top = true;
        no_gaps_when_only = false;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        vfr = true;
        hide_cursor_on_touch = true;
      };
      bind = [
        "$mainMod, B, exec, firefox"
        "$mainMod, F, fullscreen, 1"
        "$mainMod, P, pseudo"
        "$mainMod, Q, killactive"
        "$mainMod, T, togglefloating"
        "$mainMod, RETURN, exec, wezterm" 
        "$mainModShift, F, fullscreen, 0"
        "$mainModShift, Q, exit"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl stop"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindle = [
        ", XF86MonBrightnessUp, exec, brightness up"
        ", XF86MonBrightnessDown, exec, brightness down"
      ];
      windowrule = [
        "tile,title:^(wezterm)$"
      ];
    };
  };
}
