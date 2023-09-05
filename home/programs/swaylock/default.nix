{ config, lib, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      daemonize = true;
      scaling = "fill";
      effect-blur = "10x30";
      hide-keyboard-layout = true;
      clock = true;
      timestr = "%T";
      datestr = "%a, %d %b %y";
      indicator = true;
      indicator-radius = 220;
      indicator-thickness = 7;
      color = "1e1e2e";
      ring-color = "cba6f7";
      ring-ver-color = "a6e3a1";
      ring-wrong-color = "f38ba8";
      ring-clear-color = "89b4fa";
      key-hl-color = "1e1e2e";
      bs-hl-color = "eba0ac";
      text-color = "11111b";
      text-caps-lock-color = "11111b";
      line-color = "1e1e2e";
      line-ver-color = "1e1e2e";
      line-wrong-color = "f38ba8";
      line-clear-color = "89b4fa";
      separator-color = "1e1e2e";
      inside-color = "cba6f7";
      inside-ver-color = "a6e3a1";
      inside-wrong-color = "f38ba8";
      inside-clear-color = "89b4fa";
    };
  };
}
