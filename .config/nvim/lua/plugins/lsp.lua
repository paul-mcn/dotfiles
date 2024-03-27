return {
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
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	-- "OrangeT/vim-csharp",
	"Hoffs/omnisharp-extended-lsp.nvim",
	{
		"neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
		config = function()
			-- READ MORE: https://github.com/hrsh7th/nvim-cmp

			-- note: diagnostics are not exclusive to lsp servers
			-- so these can be global keybindings
			vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
			vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
			vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

			vim.api.nvim_create_autocmd('LspAttach', {
				desc = 'LSP actions',
				callback = function(event)
					local opts = { buffer = event.buf }

					-- these will be buffer-local keybindings
					-- because they only work if you have an active language server

					vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
					vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
					vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
					vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
					vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
					vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
					vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
					vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
					vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
					vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
				end
			})

			local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

			local default_setup = function(server)
				require('lspconfig')[server].setup({
					capabilities = lsp_capabilities,
				})
			end

			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = {},
				handlers = {
					default_setup,
					lua_ls = function()
						require('lspconfig').lua_ls.setup({
							capabilities = lsp_capabilities,
							settings = {
								Lua = {
									diagnostics = {
										globals = { 'vim' }
									}
								}
							}
						})
					end,
					omnisharp = function()
						require('lspconfig').omnisharp.setup({
							capabilities = lsp_capabilities,
							handlers = {
								["textDocument/definition"] = require('omnisharp_extended').definition_handler,
								["textDocument/references"] = require('omnisharp_extended').references_handler,
								["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
							}
						})
					end
				}
			})

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
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("tsx", { "html" })
		end
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				handlers = {},
			})
		end,
	}
}
