 { config, lib, pkgs, ... }:

 {
   services.dunst = {
     enable = true;
     settings = {
       global = {
         font = "RobotoMono Nerd Font";
         allow_markup = "yes";
         format = "<b>%s</b>\n%b";
         sort = "yes";
         indicate_hidden = "yes";
         alignment = "yes";
         bounce_freq = 0;
         ellipsize = "middle";
         show_age_threshold = -1;
         word_wrap = "yes";
         ignore_newline = "no";
         width = 320;
         height = 500;
         origin = "top-right";
         offset = "10x12";
         progress_bar = true;
         progress_bar_height = 14;
         progress_bar_frame_width = 1;
         progress_bar_min_width = 150;
         progress_bar_max_width = 300;
         frame_width = 3;
         frame_color = "#1c2325";
         transparency = 0;
         idle_threshold = 0;
         monitor = 0;
         follow = "none";
         show_indicators = "no";
         sticky_history = "yes";
         line_height = 8;
         separator_color = "frame";
         separator_height = 3;
         padding = 16;
         horizontal_padding = 12;
         text_icon_padding = 16;
         icon_position = "left";
         min_icon_size = 32;
         max_icon_size = 48;
         corner_radius = 17;
         always_run_script = true;
         mouse_left_click = "close_current";
         mouse_middle_click = "do_action, close_current";
         mouse_right_click = "close_all";
       };
       urgency_low = {
         timeout = 6;
         background = "#1e1e2e";
         foreground = "#cdd6f4";
         frame_color = "#89b4fa";
         highlight = "#f38ba8";
       };
       urgency_normal = {
         timeout = 6;
         background = "#1e1e2e";
         foreground = "#cdd6f4";
         frame_color = "#89b4fa";
         highlight = "#f38ba8";
       };
       urgency_critical = {
         timeout = 6;
         background = "#1e1e2e";
         foreground = "#cdd6f4";
         frame_color = "#fab387";
         highlight = "#f38ba8";
       };
       backlight = {
         summary = "Backlight";
         highlight = "#eba0ac";
         set_stack_tag = "backlight";
       };
       volume = {
         summary = "Volume";
         set_stack_tag = "volume";
       };
       volume-muted = {
         summary = "Volume Muted";
         hightlight = "#eba0ac";
       };
       volume-unmuted = {
         summary = "Volume Unmuted";
         highlight = "#eba0ac";
       };
     };
   };
 }
