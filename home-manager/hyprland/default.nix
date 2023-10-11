{ config, lib, inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    settings = {
      "$mainMod" = "SUPER";
      "$mainModShift" = "SUPERSHIFT";
      blurls = "gtk-layer-shell";
      monitor = [
        "eDP-1,2256x1504@60,0x0,1"
      ];
      exec-once = [
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "swayidle -w timeout 1200 'swaylock' timeout 1230 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock'"
        "swayidle -w timeout 15 'if pgrep -x swaylock; then hyprctl dispatch dpms off; fi' resume 'hyprctl dispatch dpms on'"
        "hyprpaper"
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
        gaps_in = 6;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(bb9af7ff) rgba(b4f9f8ff) 45deg";
        "col.inactive_border" = "rgba(565f89cc) rgba(9aa5cecc) 45deg";
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
        "$mainMod, SPACE, exec, rofi -show drun"
        "$mainMod, B, exec, firefox"
        "$mainMod, D, exec, discord"
        "$mainMod, F, fullscreen, 1"
        "$mainMod, P, pseudo"
        "$mainMod, Q, killactive"
        "$mainMod, T, togglefloating"
        "$mainMod, X, exec, swaylock"
        "$mainMod, RETURN, exec, wezterm" 
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, left, resizeactive, -40 0"
        "$mainMod, right, resizeactive, 40 0"
        "$mainMod, up, resizeactive, 0 -40"
        "$mainMod, down, resizeactive, 0 40"
        "$mainMod, F11, exec, screenshot_full"
        "$mainModShift, C, exec, hyprpicker --autocopy"
        "$mainModShift, F, fullscreen, 0"
        "$mainModShift, Q, exit"
        "$mainModShift, S, exec, screenshot_area"
        "$mainModShift, X, exec, wlogout --protocol layer-shell -b 5 -T 600 -B 600"
        "$mainModShift, h, movewindow, l"
        "$mainModShift, l, movewindow, r"
        "$mainModShift, j, movewindow, d"
        "$mainModShift, k, movewindow, u"
        "$mainModShift, 1, movetoworkspacesilent, 1"
        "$mainModShift, 2, movetoworkspacesilent, 2"
        "$mainModShift, 3, movetoworkspacesilent, 3"
        "$mainModShift, 4, movetoworkspacesilent, 4"
        "$mainModShift, 5, movetoworkspacesilent, 5"
        "$mainModShift, 6, movetoworkspacesilent, 6"
        "$mainModShift, 7, movetoworkspacesilent, 7"
        "$mainModShift, 8, movetoworkspacesilent, 8"
        "$mainModShift, 9, movetoworkspacesilent, 9"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl stop"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioMute, exec, volume mute"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindle = [
        ", XF86AudioLowerVolume, exec, volume down"
        ", XF86AudioRaiseVolume, exec, volume up"
        ", XF86MonBrightnessUp, exec, brightness up"
        ", XF86MonBrightnessDown, exec, brightness down"
      ];
      windowrule = [
        "tile,title:^(wezterm)$"
      ];
    };
  };
}
