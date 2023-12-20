{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hyprland
    ./programs
    ./services
  ];

  services = {
    blueman-applet.enable = true;
  };

  programs = {
    home-manager.enable = true;
  };

  home = {
    stateVersion = "24.05";
    file = {
      ".npmrc" = {
        enable = true;
        text = ''
          prefix = ''${HOME}/.npm-packages
        '';
      };
      ".zlogin" = {
        enable = true;
        text = ''
          dbus-run-session Hyprland
        '';
      };
      ".config/neofetch/config.conf" = {
        enable = true;
        text = ''
          LC_ALL=C
          LANG=C

          print_info() {
            prin "\n"
            prin " ──────────────── Software Information ────────────────"
            info "​$(color 6)  " distro
            info "​$(color 2)  " kernel
            info "​$(color 3)   " de
            info "​$(color 5)  " term
            info "​$(color 7)  " shell
            info "​$(color 4)  " packages
            prin " ──────────────── Hardware Information ────────────────"
            info "​$(color 9)  " model
            info "​$(color 10)  " cpu
            info "​$(color 11) 󱤓 " gpu
            info "​$(color 12) 󰄧 " memory
            info "​$(color 14)  " uptime
            prin " ──────────────────────────────────────────────────────"
            prin "\n \n ​ \n \n ​ \n \n $(color 3) \n \n $(color 4) \n \n $(color 5) \n \n $(color 6) \n \n $(color 9) \n \n $(color 2) \n \n $(color 10) \n \n $(color 12) \n \n $(color 13) \n \n $(color 1) "
          }

          title_fqdn="off"
          kernel_shorthand="on"
          distro_shorthand="off"
          os_arch="off"
          uptime_shorthand="on"
          memory_percent="on"
          memory_unit="gib"
          package_managers="on"
          shell_path="off"
          shell_version="on"
          speed_type="bios_limit"
          speed_shorthand="off"
          cpu_brand="on"
          cpu_speed="on"
          cpu_cores="logical"
          cpu_temp="on"
          gpu_brand="on"
          gpu_type="all"
          refresh_rate="on"
          gtk_shorthand="off"
          gtk2="off"
          gtk3="on"
          public_ip_host="http://ident.me"
          public_ip_timeout=2
          de_version="on"
          disk_show=('/')
          disk_subtitle="mount"
          disk_percent="on"
          music_player="auto"
          song_format="%artist% - %album% - %title%"
          song_shorthand="off"
          mpc_args=()
          colors=(distro)
          bold="on"
          underline_enabled="on"
          underline_char="-"
          separator=":"
          block_range=(0 15)
          color_blocks="on"
          block_width=3
          block_height=1
          col_offset="auto"
          bar_char_elapsed="-"
          bar_char_total="="
          bar_border="on"
          bar_length=15
          bar_color_elapsed="distro"
          bar_color_total="distro"
          cpu_display="on"
          memory_display="off"
          battery_display="off"
          disk_display="off"
          image_backend="ascii"
          image_source="${config.home.homeDirectory}/.config/neofetch/ascii.txt"
          ascii_distro="auto"
          ascii_colors=(distro)
          ascii_bold="on"
          image_loop="off"
          thumbnail_dir="${config.home.homeDirectory}/.cache/thumbnails/neofetch"
          crop_mode="normal"
          crop_offset="center"
          image_size="auto"
          gap=5
          yoffset=0
          xoffset=0
          background_color=
          stdout="off"
        '';
      };
    };
    packages = [
      inputs.dipc.packages.${pkgs.system}.default
    ];
    sessionPath = [
      "$HOME/.npm-packages/bin"
      "$HOME/.npm-packages/lib/node_modules/"
    ];
  };
  gtk = {
    enable = true;
    font.name = "RobotoMono Nerd Font 12";
    iconTheme.name = "Catppuccin-Mocha";
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "standard";
        tweaks = ["rimless" "black"];
        variant = "mocha";
      };
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk3";
  };
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
}

