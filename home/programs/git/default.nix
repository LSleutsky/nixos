{ config, lib, pkgs, ... }:

{
  programs = {
    gh = {
      enable = true;
	    settings = {
		    browser = "firefox";
		    editor = "nvim";
		    git_protocol = "https";
		    pager = "less";
		    aliases = {
          al = "auth login";
			    rc = "repo create";
			    rcl = "repo clone";
		    };
	    };
    };
    git = {
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
          directory = "/home/lush/.local/share/nvim/lazy/base46";
        };
      };
      userEmail = "LushSleutsky@gmail.com";
      userName = "LSleutsky";
    };
    gitui = {
      enable = true;
    };
  };
}
