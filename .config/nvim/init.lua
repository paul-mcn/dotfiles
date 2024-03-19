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

-- Plugins

-- require("lazy").setup("plugins")
require("lazy").setup({
	"nvim-tree/nvim-web-devicons",
	"folke/which-key.nvim",
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	"williamboman/mason.nvim",          -- Automatically install LSPs to stdpath for neovim
	"williamboman/mason-lspconfig.nvim", -- closes some gaps that exist between mason.nvim and lspconfig
	"nvim-lualine/lualine.nvim",        -- Fancier statusline
	{ "rose-pine/neovim",                name = "rose-pine" },
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	"neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
	{ "rafamadriz/friendly-snippets" },
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	{
		"kkoomen/vim-doge",
		build = ":call doge#install()" -- For generating documentation. Sometimes needs to be manually called
	},
	"jiangmiao/auto-pairs",
	"tomtom/tcomment_vim",
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
	"napmn/react-extract.nvim",
	"christoomey/vim-tmux-navigator",
	"tpope/vim-fugitive",
	{
		'Exafunction/codeium.vim',
		event = 'BufEnter',
	},
	-- "jlcrochet/vim-razor",
	-- "adamclerk/vim-razor",
	-- "OmniSharp/omnisharp-vim",
	"OrangeT/vim-csharp",
	"Hoffs/omnisharp-extended-lsp.nvim"
})

-- Setup Plugins

require('nvim-web-devicons').setup({
	-- your personnal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh"
		}
	},
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
	color_icons = true,
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true,
	-- globally enable "strict" selection of icons - icon will be looked up in
	-- different tables, first by filename, and if not found by extension; this
	-- prevents cases when file doesn't have any extension but still gets some icon
	-- because its name happened to match some extension (default to false)
	strict = true,
	-- same as `override` but specifically for overrides by filename
	-- takes effect when `strict` is true
	override_by_filename = {
		[".gitignore"] = {
			icon = "",
			color = "#f1502f",
			name = "Gitignore"
		}
	},
	-- same as `override` but specifically for overrides by extension
	-- takes effect when `strict` is true
	override_by_extension = {
		["log"] = {
			icon = "",
			color = "#81e043",
			name = "Log"
		}
	},
})
require("mason").setup()
require("mason-lspconfig").setup()
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
})
vim.cmd("colorscheme rose-pine-moon")
require("nvim-treesitter.configs").setup {
	ensure_installed = { "lua", "javascript", "typescript", "vimdoc" },
	highlight = {
		enable = true,
	}
}
require("mason-null-ls").setup({
	ensure_installed = {},
	automatic_installation = false,
	handlers = {}
})
require("null-ls").setup({
	sources = {
		-- Anything not supported by mason.
	}
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("tsx", { "html" })

-- READ MORE: https://github.com/hrsh7th/nvim-cmp
local cmp = require("cmp")
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},

	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},

	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),

	sources = cmp.config.sources({
		{ name = 'nvim_lsp', max_item_count = 20 },
		{ name = 'luasnip',  max_item_count = 10 },
		{ name = "path" },
		{ name = 'buffer',   max_item_count = 10 },
	}),

	experimental = {
		ghost_text = true,
	}
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer', keyword_length = 3 }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline', keyword_length = 3 }
	})
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')
lspconfig.tsserver.setup {
	capabilities = capabilities
}
lspconfig.lua_ls.setup(
	{
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' }
				}
			}
		}
	}
)
lspconfig.tailwindcss.setup {
	capabilities = capabilities,
}
lspconfig.emmet_language_server.setup {
	capabilities = capabilities
}
lspconfig.pyright.setup {
	capabilities = capabilities
}
lspconfig.clangd.setup {
	capabilities = capabilities
}
lspconfig.omnisharp.setup {
	capabilities = capabilities,
	handlers = {
		["textDocument/definition"] = require("omnisharp_extended").handler
	}
}

-- Keybindings
local wk = require("which-key")
wk.register({
	["gD"] = { vim.lsp.buf.declaration, "Go to declaration" },
	["gd"] = { vim.lsp.buf.definition, "Go to definition" },
	["[d"] = { vim.diagnostic.goto_prev, "Next diagnostic" },
	["]d"] = { vim.diagnostic.goto_next, "Prev diagnostic" },
	["K"] = { vim.lsp.buf.hover, "Displays information on symbol under cursor" },
	["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "Navigate Left" },
	["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", "Navigate Down" },
	["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", "Navigate Up" },
	["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", "Navigate Right" },
	-- ["<C-space>"] = { "<cmd>call codeium#Complete()<cr>", "Trigger Codeium suggestion" }
})

wk.register({
	w = {
		name = "Workspace",
		a = { vim.lsp.buf.add_workspace_folder, "Workspace Add" },
		r = { vim.lsp.buf.remove_workspace_folder, "Workspace Remove" },
		l = { (function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end), "Workspace list" },
	},
	s = {
		name = "Search",
		f = { "<cmd>Telescope find_files<cr>", "Search File" },
		r = { "<cmd>Telescope oldfiles<cr>", "Search Recent File" },
		t = { "<cmd>Telescope live_grep<cr>", "Search text" },
		b = { "<cmd>Telescope buffers<cr>", "Search buffer" },
		h = { "<cmd>Telescope help_tags<cr>", "Search help tags" },
	},
	od = { vim.diagnostic.open_float, "Open diagnostic float", name = "Open" },
	pv = { "<cmd>:Explore<cr>", "Project view", name = "Project" },
	l = {
		name = "Diagnostics",
		l = { vim.diagnostic.setloclist, "Location list" },
		f = { function()
			vim.lsp.buf.code_action({
				filter = function(a) return a.isPreferred end,
				apply = true
			})
		end, "Little Fix" },
	},
	h = { vim.lsp.buf.signature_help, "Signature help" },
	rn = { vim.lsp.buf.rename, "Rename variable", name = "Rename" },
	C = { "<cmd>:e ~/.config/nvim/init.lua<cr>", "Edit Nvim Config" },
	ca = { vim.lsp.buf.code_action, "Code Action", name = "Code Action", mode = { "n", "v" } },
	ft = {
		function()
			vim.lsp.buf.format { async = true }
		end,
		"Format text",
		name = "Format"
	},
	e = {
		name = "Extract",
		n = { require("react-extract").extract_to_new_file, "Extract to New file", mode = "v" },
		c = { require("react-extract").extract_to_current_file, "Extract to Current file", mode = "v" },
	}
}, { prefix = "<leader>" })

require("react-extract").setup()

-- Settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.g.cmp_completion_max_width = 30
vim.wo.number = true         -- Add number lines
vim.opt.scrolloff = 8        -- Min number of context lines above and below the cursor
vim.opt.signcolumn = "yes:2" -- Add spacing for diagnostics on column. Also prevent window shifting.
vim.cmd [[
	augroup highlight_yank
			autocmd!
			au TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=100})
	augroup END
]] -- Add highlight on yank

-- Checks if there is a file open after Vim starts up,
-- and if not, open the current working directory in Netrw.
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
