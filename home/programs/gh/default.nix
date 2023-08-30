{ config, lib, pkgs, ... }:

{
  programs.gh = {
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
}
