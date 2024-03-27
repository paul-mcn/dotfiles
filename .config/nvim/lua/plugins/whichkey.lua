return {
	"folke/which-key.nvim",
	config = function()
		local wk = require("which-key")
		wk.register({
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
	end,
}
