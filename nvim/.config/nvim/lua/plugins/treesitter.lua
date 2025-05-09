return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = { "lua", "javascript", "typescript", "vimdoc" },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = {"php"}
			}
		}
	end
}
