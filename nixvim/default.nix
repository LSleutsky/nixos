{ config, lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
		enableMan = true;
		vimAlias = true;
    colorschemes.tokyonight = {
      enable = true;
      lualineBold = true;
      style = "night";
    };
    options = {
      autoindent = true;
      preserveindent = true;
			smartindent = true;
			incsearch = true;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      swapfile = false;
    };
		keymaps = [
			{
				mode = "n";
				key = "<C-s>";
				action = ":w<CR>";
			}
			{
				mode = [ "n" "v" ];
				key = "-";
				action = ":qa!<CR>";
			}
			{
				key = "<esc>";
				action = ":noh<CR>";
				options = {
					silent = true;
				};
			}
			{
				mode = "v";
				key = ">gv";
				action = ">";
			}
			{
				mode = "v";
				key = "<gv";
				action = "<";
			}
			{
				mode = "i";
				key = "<C-s>";
				action = "<esc>:w<CR>";
			}
		];
  };
}
