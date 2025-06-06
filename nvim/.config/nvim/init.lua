local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- set `mapleader` before lazy so the mappings are correct

require("lazy").setup({
	{
		"kkoomen/vim-doge",
		build = ":call doge#install()", -- For generating documentation. Sometimes needs to be manually called
	},
	"jiangmiao/auto-pairs",
	"christoomey/vim-tmux-navigator",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"tpope/vim-fugitive",
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
	},
	{ import = "plugins" },
}, {})

-- Settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.g.cmp_completion_max_width = 30
vim.wo.number = true         -- Add number lines
vim.opt.scrolloff = 8        -- Min number of context lines above and below the cursor
vim.opt.signcolumn = "yes:2" -- Add spacing for diagnostics on column. Also prevent window shifting.
vim.g.doge_javascript_settings = {
	destructuring_props = 1,
	omit_redundant_param_types = 1,
}
vim.g.doge_mapping_comment_jump_forward = "<C-n>"
vim.g.doge_mapping_comment_jump_backward = "<C-p>"

-- Add highlight on yank
vim.cmd([[
	augroup highlight_yank
			autocmd!
			au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=100})
	augroup END
]])

-- Opens netrw if no file args
vim.cmd([[
	augroup InitNetrw
		autocmd!
		autocmd VimEnter * if argc() == 0 | Explore | endif
	augroup END
]])

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
	return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
			or get_option(filetype, option)
end

-- vim.cmd [[
-- 	augroup filetype_jsx
-- 			autocmd!
-- 			autocmd FileType javascript set filetype=typescriptreact
-- 			autocmd FileType javascriptreact set filetype=typescriptreact
-- 	augroup END
-- ]]
