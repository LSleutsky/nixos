{ config, lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
		enableMan = true;
		vimAlias = true;
    globals.mapleader = " ";
    colorschemes.catppuccin = {
      enable = true;
      background.dark = "mocha";
      flavour = "mocha";
      terminalColors = true;
      integrations = {
        gitsigns = true;
        native_lsp.enabled = true;
        navic.enabled = true;
        nvimtree = true;
        telescope.enabled = true;
        treesitter = true;
        treesitter_context = true;
        ts_rainbow2 = true;
        illuminate = {
          enabled = true;
          lsp = true;
        };
        indent_blankline = {
          enabled = true;
          colored_indent_levels = true;
        };
      };
      styles = {
        booleans = ["bold" "italic"];
        conditionals = ["bold"];
        functions = ["bold"];
        keywords = ["italic"];
        loops = ["bold"];
        operators = ["bold"];
        properties = ["italic"];
      };
    };
    options = {
			incsearch = true;
      number = true;
      numberwidth = 2;
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      expandtab = true;
      autoindent = true;
      preserveindent = true;
			smartindent = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      signcolumn = "yes";
      termguicolors = true;
      mouse = "a";
      swapfile = false;
    };
    autoCmd = [
      {
        event = "FileType";
        pattern = "qf";
        callback = {
          __raw = ''
            function()
              vim.opt_local.buflisted = false
            end
          '';
        };
      }
      {
        event = "TextYankPost";
        pattern = "*";
        callback = {
          __raw = ''
            function()
              vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 250 })
            end
          '';
        };
      }
      {
        event = "VimResized";
        pattern = "*";
        command = "tabdo wincmd =";
      }
    ];
		keymaps = [
			{
        mode = "n";
				key = "<esc>";
				action = ":noh<CR>";
				options = {
					silent = true;
				};
			}
			{
				mode = "n";
				key = "-";
				action = ":qa<CR>";
        options = {
          desc = "Exit";
        };
			}
      {
        mode = "n";
        key = ";";
        action = ":";
        options = {
          desc = "Enter command mode";
          nowait = true;
        };
      }
      {
        mode = "n";
        key = "<C-a>";
        action = "gg0VG";
        options = {
          desc = "Select all";
        };
      }
      {
        mode = "n";
        key = "<C-c>";
        action = ":%y+<CR>";
        options = {
          desc = "Copy all";
        };
      }
			{
				mode = "n";
				key = "<C-s>";
				action = ":w<CR>";
        options = {
          desc = "Save current buffer";
        };
			}
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          desc = "Window left";
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          desc = "Window right";
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          desc = "Window down";
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          desc = "Window up";
        };
      }
      {
        mode = "n";
        key = "<C-x>";
        action = "<C-w>c";
        options = {
          desc = "Close window";
        };
      }
      {
        mode = "n";
        key = "<S-down>";
        action = ":m+<CR>==";
        options = {
          desc = "Move selected text down";
        };
      }
      {
        mode = "n";
        key = "<S-up>";
        action = ":m-2<CR>==";
        options = {
          desc = "Move selected text up";
        };
      }
      {
        mode = "n";
        key = "<leader>b";
        action = ":enew<CR>";
        options = {
          desc = "new buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "q";
        action = ":BufferClose<CR>";
        options = {
          desc = "Close current buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<tab>";
        action = ":BufferNext<CR>";
        options = {
          desc = "Go to next buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<S-tab>";
        action = ":BufferPrevious<CR>";
        options = {
          desc = "Go to previous buffer";
          silent = true;
        };
      }
      {
        mode = ["n" "v"];
        key = "x";
        action = "\"_x";
        options = {
          desc = "Don't yank deleted char";
        };
      }
      {
        mode = ["n" "v"];
        key = "x";
        action = "\"_x";
        options = {
          desc = "Don't yank deleted char";
        };
      }
			{
				mode = "v";
				key = ">gv";
				action = ">";
        options = {
          desc = "Move line 2 spaces forward";
        };
			}
			{
				mode = "v";
				key = "<gv";
				action = "<";
        options = {
          desc = "Move line 2 spaces backward";
        };
			}
      {
        mode = "i";
        key = "<C-b>";
        action = "<esc>^i";
        options = {
          desc = "Go to beginning of line";
        };
      }
      {
        mode = "i";
        key = "<C-e>";
        action = "<End>";
        options = {
          desc = "Go to end of line";
        };
      }
      {
        mode = "i";
        key = "<C-h>";
        action = "<Left>";
        options = {
          desc = "Move left";
        };
      }
      {
        mode = "i";
        key = "<C-l>";
        action = "<Right>";
        options = {
          desc = "Move right";
        };
      }
      {
        mode = "i";
        key = "<C-j>";
        action = "<Down>";
        options = {
          desc = "Move down";
        };
      }
      {
        mode = "i";
        key = "<C-k>";
        action = "<Up>";
        options = {
          desc = "Move up";
        };
      }
			{
				mode = "i";
				key = "<C-s>";
				action = "<esc>:w<CR>";
        options = {
          desc = "Save current buffer";
        };
			}
		];
		plugins = {
			cursorline.enable = true;
			illuminate.enable = true;
			indent-blankline.enable = true;
			nix.enable = true;
			nix-develop.enable = true;
			surround.enable = true;
      ts-autotag.enable = true;
      barbar = {
        enable = true;
        autoHide = false;
        clickable = true;
        icons = {
          visible.bufferNumber = true;
          current = {
            filetype.enable = true;
            pinned.filetype.enable = true;
          };
        };
      };
      lualine = {
        enable = true;
        iconsEnabled = true;
        theme = "catppuccin";
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff" "diagnostics"];
          lualine_c = ["filename"];
          lualine_x = ["filetype"];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };
      };
			navic = {
				enable = true;
				highlight = true;
        lsp.autoAttach =  true;
			};
      nvim-autopairs = {
        enable = true;
        enableAfterQuote = true;
        enableBracketInQuote = true;
        enableCheckBracketLine = false;
        enableMoveright = true;
      };
			nvim-colorizer = {
				enable = true;
				userDefaultOptions = {
					css = true;
					css_fn = true;
					hsl_fn = true;
					names = true;
					rgb_fn = true;
					tailwind = true;
				};
			};
      treesitter = {
        enable = true;
        incrementalSelection.enable = true;
        indent = true;
        nixGrammars = true;
        nixvimInjections = true;
      };
			vim-matchup = {
				enable = true;
				enableSurround = true;
				textObj.enable = true;
				treesitterIntegration.enable = true;
				matchParen = {
					enable = true;
					deffered.enable = true;
					hiSurroundAlways = true;
				};
			};
		};
  };
}
