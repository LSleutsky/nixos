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
			    rc = "repo create";
			    rcl = "repo clone";
		    };
	    };
    };
    git = {
      enable = true;
      package = pkgs.gitFull;
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
        "*.swp"
        "Thumbs.db"
        ".yarn"
      ];
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        push = {
          autoSetupRemote = true;
        };
        safe = {
          directory = "$HOME/.local/share/nvim/lazy/*";
        };
      };
      userEmail = "LushSleutsky@gmail.com";
      userName = "LSleutsky";
    };
  };
}
