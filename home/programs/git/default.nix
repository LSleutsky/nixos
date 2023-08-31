{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        commit-decoration-style = "bold box ul #450eff";
        file-decoration-style = "#606018 ul";
        line-numbers = true;
        side-by-side = true;
      };
    };
    ignores = [
      ".DS_Store"
      "*.log"
      "node_modules"
      ".npm"
      "Thumbs.db"
      ".yarn"
    ];
    extraConfig = {
      safe = {
        directory = "/home/lush/.local/share/nvim/lazy/*";
      };
    };
    userEmail = "LushSleutsky@gmail.com";
    userName = "LSleutsky";
  };
}
