return {
	"folke/which-key.nvim",
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<C-h>",      "<cmd>TmuxNavigateLeft<cr>",         desc = "Navigate Left" },
			{ "<C-j>",      "<cmd>TmuxNavigateDown<cr>",         desc = "Navigate Down" },
			{ "<C-k>",      "<cmd>TmuxNavigateUp<cr>",           desc = "Navigate Up" },
			{ "<C-l>",      "<cmd>TmuxNavigateRight<cr>",        desc = "Navigate Right" },
			{ "<leader>w",  group = "Workspace" },
			{ "<leader>wa", vim.lsp.buf.add_workspace_folder,    desc = "Workspace Add" },
			{ "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Workspace Remove" },
			{
				"<leader>wl",
				(function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end),
				desc = "Workspace list"
			},
			{ "<leader>s",  group = "Search" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "[S]earch [C]ommand history" },
			{ "<leader>sl", "<cmd>Telescope resume<cr>",          desc = "[S]earch [L]ast" },
			{ "<leader>sd", "<cmd>Telescope diagnostics<cr>",     desc = "[S]earch [D]iagnostics" },
			{ "<leader>s.", "<cmd>Telescope dotfiles<cr>",        desc = "[S]earch Dotfiles" },
			{ "<leader>sf", "<cmd>Telescope find_files<cr>",      desc = "[S]earch [F]iles" },
			{ "<leader>sr", "<cmd>Telescope oldfiles<cr>",        desc = "[S]earch [R]ecent files" },
			{ "<leader>sb", "<cmd>Telescope buffers<cr>",         desc = "[S]earch [B]uffers" },
			{ "<leader>st", "<cmd>Telescope live_grep<cr>",       desc = "[S]earch [T]ext" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>",       desc = "[S]earch [h]elp tags" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>",      desc = "[S]earch [H]ighlights" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>",         desc = "[S]earch [K]eymaps" },
			{ "<leader>od", vim.diagnostic.open_float,            desc = "Open diagnostic float",     name = "Open" },
			{ "<leader>pv", "<cmd>:Explore<cr>",                  desc = "Project view",              name = "Project" },
			{ "<leader>l",  group = "LSP" },
			{ "<leader>ll", vim.diagnostic.setloclist,            desc = "Location list" },
			{
				"<leader>lf",
				function()
					vim.lsp.buf.code_action({
						filter = function(a) return a.isPreferred end,
						apply = true
					})
				end,
				desc = "Little Fix"
			},
			{
				"<leader>C", -- edit file
				function()
					--  "<cmd>:e ~/.config/nvim/init.lua<cr>"
					vim.cmd(":e ~/.config/nvim/init.lua")
				end,
				desc = "Edit Nvim Config"
			},
			{
				"<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }
			},
			{ "<leader>f",  group = "Format" },
			{ "<leader>ft", function() vim.lsp.buf.format { async = true } end, desc = "Format text" },
			{ "<leader>e",  group = "React Extract" },
			{ "<leader>en", require("react-extract").extract_to_new_file,       desc = "Extract to New file",     mode = "v" },
			{ "<leader>ec", require("react-extract").extract_to_current_file,   desc = "Extract to Current file", mode = "v" },
			-- ["<F5>"] = {function ()
			-- 	local ft = vim.bo.filetype
			-- 	if ft == "javascript" or ft == "typescript" then
			-- 		vim.cmd("!node %")
			-- 	end
			-- end, "Continue"},
			-- ["<C-space>"] = { "<cmd>call codeium#Complete()<cr>", "Trigger Codeium suggestion" }
		})
	end,
}
