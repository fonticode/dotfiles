return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua, -- lua
				null_ls.builtins.formatting.black, -- python
				null_ls.builtins.diagnostics.mypy,
				-- null_ls.builtins.diagnostics.ruff,
				null_ls.builtins.formatting.clang_format, -- c/c++
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
