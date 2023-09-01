{ config, lib, pkgs, ... }:

let
  brightness = pkgs.writeShellScriptBin "brightness" ''
    down() {
      brillo -U 2
      brightness=$(printf "%.0f\n" `brillo -G`)
      dunstify -a "BRIGHTNESS" "$brightness%" -h int:value:"$brightness" -i ~/nixos/home/scripts/brightness/assets/brightness_down.png -r 2593 -u normal
    }

    up() {
      brillo -A 2
      brightness=$(printf "%.0f\n" `brillo -G`)
      dunstify -a "BRIGHTNESS" "$brightness%" -h int:value:"$brightness" -i ~/nixos/home/scripts/brightness/assets/brightness_up.png -r 2593 -u normal
    }

    case "$1" in
      up) up;;
      down) down;;
    esac
  '';
in {
  home.packages = with pkgs; [ brightness ];
}
