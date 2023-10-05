{ config, lib, pkgs, ... }:

let
  volume = pkgs.writeShellScriptBin "volume" ''
    down() {
      [[ `wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED` ]] && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
      wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 2%-
      volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/Volume: //')
      volume=$(echo $volume | awk -v volume=$volume "{ print(volume * 100) }")
      dunstify -a "VOLUME" "$volume%" -h int:value:"$volume" -i ~/nixos/scripts/volume/assets/volume_down.png -r 2593 -u normal
    }

    up() {
      [[ `wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED` ]] && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
      wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 2%+
      volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/Volume: //')
      volume=$(echo $volume | awk -v volume=$volume "{ print(volume * 100) }")
      dunstify -a "VOLUME" "$volume%" -h int:value:"$volume" -i ~/nixos/scripts/volume/assets/volume_up.png -r 2593 -u normal
    }

    mute() {
      if [[ `wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED` ]]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        dunstify -a "VOLUME" "UNMUTED" -i ~/nixos/scripts/volume/assets/volume_up.png -r 2593 -u normal
      else
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
        dunstify -a "VOLUME" "MUTED" -i ~/nixos/scripts/volume/assets/volume_muted.png -r 2593 -u normal
      fi
    }

    case "$1" in
      up) up;;
      down) down;;
      mute) mute;;
    esac
  '';
in {
  environment.systemPackages = with pkgs; [ volume ];
}
