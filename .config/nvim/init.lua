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
		build = ":call doge#install()" -- For generating documentation. Sometimes needs to be manually called
	},
	"jiangmiao/auto-pairs",
	"tomtom/tcomment_vim",
	"christoomey/vim-tmux-navigator",
	"tpope/vim-fugitive",
	{
		'Exafunction/codeium.vim',
		event = 'BufEnter',
	},
	"OrangeT/vim-csharp",
	"Hoffs/omnisharp-extended-lsp.nvim",
	{ import = "plugins" }
}, {})


-- Settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.g.cmp_completion_max_width = 30
vim.wo.number = true         -- Add number lines
vim.opt.scrolloff = 8        -- Min number of context lines above and below the cursor
vim.opt.signcolumn = "yes:2" -- Add spacing for diagnostics on column. Also prevent window shifting.

-- Add highlight on yank
vim.cmd [[
	augroup highlight_yank
			autocmd!
			au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=100})
	augroup END
]]

-- Opens netrw if no file args
vim.cmd [[
	augroup InitNetrw
		autocmd!
		autocmd VimEnter * if argc() == 0 | Explore | endif
	augroup END
]]
-- vim.cmd [[
-- 	augroup filetype_jsx
-- 			autocmd!
-- 			autocmd FileType javascript set filetype=typescriptreact
-- 			autocmd FileType javascriptreact set filetype=typescriptreact
-- 	augroup END
-- ]]
