{ config, lib, pkgs, ... }:

{
  programs = {
    gitui.enable = true;
    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
        hosts = ["https://github.com"];
      };
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
        "*.swp"
        "Thumbs.db"
        ".yarn"
      ];
      extraConfig = {
        credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
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
