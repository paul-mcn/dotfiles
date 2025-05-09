return {
	"folke/which-key.nvim",
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate Left" },
			{ "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate Down" },
			{ "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate Up" },
			{ "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate Right" },
			{ "K", vim.lsp.buf.hover, desc = "Show LSP Hover" },
			{ "<leader>w", group = "Workspace", icon = " " },
			{ "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Workspace Add" },
			{ "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Workspace Remove" },
			{
				"<leader>wl",
				function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end,
				desc = "Workspace list",
			},
			{ "<leader>s", group = "Search" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "[s]earch [c]ommand history" },
			{ "<leader>sl", "<cmd>Telescope resume<cr>", desc = "[s]earch [l]ast" },
			{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "[s]earch [d]iagnostics" },
			{
				"<leader>sf",
				function()
					require("telescope.builtin").find_files({
						hidden = true,
						no_ignore = true,
						file_ignore_patterns = { "node_modules", ".git", "dist", ".expo", "android" },
					})
				end,
				desc = "[s]earch [f]iles",
			},
			{ "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "[s]earch [r]ecent files" },
			{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "[s]earch [b]uffers" },
			{ "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "[s]earch [t]ext" },
			{
				"<leader>sT",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "[s]earch [T]ext on current file",
			},
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[s]earch [h]elp tags" },
			{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "[s]earch [H]ighlights" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[s]earch [k]eymaps" },
			{ "<leader>p", group = "Project", icon = "📂" },
			{
				"<leader>pv",
				"<cmd>:Explore<cr>",
				desc = "Project view",
				name = "[p]roject [v]iew",
			},
			{ "<leader>l", group = "LSP", icon = "" },
			{ "<leader>ll", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble [l]sp diagnostics" },
			{
				"<leader>ld",
				vim.diagnostic.open_float,
				desc = "Open diagnostic float at cursor",
				name = "[l]sp [d]iagnostic float",
			},
			{
				"<leader>lf",
				function()
					vim.lsp.buf.code_action({
						filter = function(a)
							return a.isPreferred
						end,
						apply = true,
					})
				end,
				desc = "Little Fix",
			},
			{
				"<leader>C", -- edit file
				function()
					--  "<cmd>:e ~/.config/nvim/init.lua<cr>"
					vim.cmd(":e ~/.config/nvim/init.lua")
				end,
				desc = "Edit Nvim [C]onfig",
				icon = "📝",
			},
			{
				"<leader>c",
				group = "Code",
				mode = { "n", "v" },
				desc = "Code Action",
			},
			{
				"<leader>ca",
				vim.lsp.buf.code_action,
				desc = "[c]ode [a]ction",
				mode = { "n", "v" },
			},
			{ "<leader>f", group = "Format" },
			{
				"<leader>ft",
				function()
					vim.lsp.buf.format({ async = true })
				end,
				desc = "[f]ormat [t]ext",
			},
			{ "<leader>e", group = "Extract", mode = "v", desc = "Extract" },
			{
				"<leader>en",
				require("react-extract").extract_to_new_file,
				desc = "React [e]xtract to [n]ew file",
				mode = "v",
			},
			{
				"<leader>ec",
				require("react-extract").extract_to_current_file,
				desc = "React [e]xtract to [c]urrent file",
				mode = "v",
			},
			{
				"<C-n>",
				function()
					require("luasnip").jump(1)
				end,
				desc = "Jump forward in Snippet",
				mode = "n",
			},
			{
				"<C-p>",
				function()
					require("luasnip").jump(-1)
				end,
				desc = "Jump backward in Snippet",
				mode = "n",
			},
			{
				"<leader>y",
				function()
					-- use clip.exe on highlighted text
					vim.cmd("call system('clip.exe', @\")")
				end,
				desc = "Copy last visual selection to clip.exe",
				mode = { "n", "v" },
				name = "pipe last [y]ank to clip.exe",
				-- windows icon
				icon = " ",
			},
			{
				"<leader>d",
				"<Plug>(doge-generate)",
				desc = "Doge Generate",
				mode = { "n", "v" },
				name = "[d]ocumentation generate",
				icon = "📜",
			},
			{ "<leader>n", group = "No", icon = "🚫" },
			{ "<leader>nh", "<cmd>nohlsearch<cr>", desc = "no [h]ighlight" },
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
