return {

	--- Theme
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		},
	},

	---	Extras:
	---		Add "vim.g.lazyvim_check_order = false" in ~/.config/nvim/lua/config/options.lua
	---		To disblable plugin order warning (unadressed issue)
	{ import = "lazyvim.plugins.extras.lang.cmake" },
	{ import = "lazyvim.plugins.extras.lang.docker" },
	{ import = "lazyvim.plugins.extras.lang.markdown" },
	{ import = "lazyvim.plugins.extras.lang.python" },
	{ import = "lazyvim.plugins.extras.lang.yaml" },
	{ import = "lazyvim.plugins.extras.lang.clangd" },
	{ import = "lazyvim.plugins.extras.lang.json" },
	{ import = "lazyvim.plugins.extras.lang.rust" },
	{ import = "lazyvim.plugins.extras.lang.toml" },
	{ import = "lazyvim.plugins.extras.dap.core" },

	--- Treesitter syntax highlighting (not included in extras)
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"csv",
				"make",
				"doxygen",
				"rasi",
				"tmux",
				"usd",
				"cuda",
				"glsl",
				"wgsl",
				"wgsl_bevy",
				"gdscript",
				"gdshader",
				"zathurarc",
			},
		},
	},

	--- Neo-tree unhide dotfiles
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
		},
	},

	--- Vim Tmux Navigator
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	--- Hardtime (learn proper vim motions)
	-- {
	-- 	"m4xshen/hardtime.nvim",
	-- 	lazy = false,
	-- 	dependencies = { "MunifTanjim/nui.nvim" },
	-- 	opts = {},
	-- },
}
