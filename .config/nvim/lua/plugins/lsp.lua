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
	{
		"neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
		config = function()
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
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("tsx", { "html" })

			local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local lspconfig = require('lspconfig')
			local lsp_servers = {
				{ name = "tsserver" },
				{
					name = "lua_ls",
					config = {
						settings = {
							Lua = {
								diagnostics = {
									globals = { 'vim' }
								}
							}
						}
					}
				},
				{ name = "tailwindcss", },
				{ name = "emmet_ls", },
				{ name = "pyright", },
				{ name = "clangd", },
				{
					name = "omnisharp",
					config = {
						handlers = {
							["textDocument/definition"] = require("omnisharp_extended").handler
						}
					}
				},
			}
			for key, value in pairs(lsp_servers) do
				if (value.config) then
					value.config.capabilities = capabilities
					lspconfig[value.name].setup(value.config)
				else
					lspconfig[value.name].setup {
						capabilities = capabilities
					}
				end
			end
		end
	},
}
