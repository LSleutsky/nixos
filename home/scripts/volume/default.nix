{ config, lib, pkgs, ... }:

let
  volume = pkgs.writeShellScriptBin "volume" ''
    down() {
	    [[ `pulsemixer --get-mute` == 1 ]] && pulsemixer --unmute
	    pulsemixer --max-volume 100 --change-volume -2
      volume=$(pulsemixer --get-volume | cut -d' ' -f1)
      [$volume -gt 0 ] && volume=`expr $volume`  
      dunstify -a "VOLUME" "$volume%" -h int:value:"$volume" -i ~/nixos/home/scripts/volume/assets/volume_down.png -r 2593 -u normal
    }

    up() {
	    [[ `pulsemixer --get-mute` == 1 ]] && pulsemixer --unmute
	    pulsemixer --max-volume 100 --change-volume +2
      volume=$(pulsemixer --get-volume | cut -d' ' -f1)
      [ $volume -lt 1000 ] && volume=`expr $volume`  
      dunstify -a "VOLUME" "$volume%" -h int:value:"$volume" -i ~/nixos/home/scripts/volume/assets/volume_up.png -r 2593 -u normal
    }

    
    mute() {
	    if [[ `pulsemixer --get-mute` == 1 ]]; then
        pulsemixer --toggle-mute
        dunstify -a "VOLUME" "UNMUTED" -i ~/nixos/home/scripts/volume/assets/volume_up.png -r 2593 -u normal
      else 
        pulsemixer --toggle-mute
        dunstify -a "VOLUME" "MUTED" -i ~/nixos/home/scripts/volume/assets/volume_muted.svg -r 2593 -u normal
      fi
    }

    case "$1" in
      up) up;;
      down) down;;
      mute) mute;;
    esac
  '';
in {
  home.packages = with pkgs; [ volume ];
}
