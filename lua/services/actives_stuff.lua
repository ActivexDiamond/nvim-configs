local M = {}

M.setup = U.Service(function()
	--TODO: Figure out what this does.
	Events.plugin_setup()
end)

M.a_vim = U.Service({ { FT.CONF, 'a.vim' } }, {}, function()
end)

M.autopairs = U.Service({ { FT.CONF, 'autopairs' } }, {}, function()
	--require 'nvim-autopairs'.setup()
end)

M.todo_comments = U.Service({ { FT.CONF, 'todo-comments' } }, {}, function()
	--TODO: Personalise this config.
	require 'todo-comments'.setup {
		highlight = {
			keyword = "bg",
		}
	}
end)

M.navbuddy = U.Service({ { FT.CONF, 'navbuddy' } }, {}, function()
	local actions = require("nvim-navbuddy.actions")
	require 'nvim-navbuddy'.setup {
		lsp = { auto_attach = true },
		mappings = {
			["<down>"] = actions.next_sibling(), -- down
			["<up>"] = actions.previous_sibling(), -- up
			["<left>"] = actions.parent(), -- Move to left panel
			["<right>"] = actions.children(), -- Move to right panel

			["<space>"] = actions.root(), -- Move to first panel

			["<C-Down"] = actions.move_down(), -- Move focused node down  FIXME: This down's work for some reason? Only the down motion!
			["<C-Up>"] = actions.move_up(), -- Move focused node up

			["X"] = actions.hsplit(),     -- Open selected node in a vertical split
			["x"] = actions.vsplit(),     -- Open selected node in a horizontal split

			["t"] = actions.telescope({ layout_strategy = 'vertical' })
		}
	}
end)

--FIXME: For some reason this one doesn't work with Venom's config system.
M.outline = {
	outline_window = {
		width = 30,
		relative_width = false,
	},
	preview_window = {
		auto_preview = true,
		open_hover_on_preview = true, --Doesn't seem to work?
		live = true,
	},
	keymaps = {
		close = '<escape>',
		restore_location = 'q',
		toggle_preview = 'f',
		hover_symbol = 'g',
		goto_location = { '<CR>', '<space>' },
		peek_location = { '<S-CR>', '<S-space>' },
		goto_and_close = { '<C-CR>' }, --<C-space> is used to toggle focus. Plus, I rarely use this particular bind anyways.

		fold_all = 'z',
		unfold_all = 'Z',
		fold_toggle_all = '<C-z>',
		fold_reset = '<S-tab>',
	},
	symbols = {
		filter = {
			lua = { 'Variable', exclude = true }
		},
	},
}
--M.outline = U.Service({{FT.CONF, 'outline'}}, {}, function()
--	require 'outline'.setup{
--	}
--end)

M.toggle_term = U.Service({ { FT.CONF, "toggleterm.nvim" } }, {}, function()
	require 'toggleterm'.setup {
		open_mapping = '<C-m>',

		insert_mappings = true,
		terminal_mappings = true,
		direction = 'horizontal',
		autochdir = true,
		size = function(term)
			if term.direction == "horizontal" then
				return 20
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		highlights = {
			CursorLine = {},
		},
		winbar = {
			enabled = false,
		},
		persist_size = true,
		persist_mode = true,
	}

	local Terminal = require 'toggleterm.terminal'.Terminal
	local lazygit = Terminal:new({
		cmd = 'lazygit',
		hidden = true,
		dir = 'git_dir', --dur param doesn't currently work, regardless of how/where you call TogglTerm.
		direction = 'float',
		float_opts = { border = 'double' },
		--Not sure what the startinsert stuff is doing. It seems to work just the same without it?
		on_open = function(term)
			--		vim.cmd('startinsert!')
			vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
		end,
		on_close = function(term)
			--		vim.cmd('startinsert!')
		end,
	})
	function _toggle_lazygit_term() lazygit:toggle() end

	local shouldResetState
	local current_project_run_sh = Terminal:new({
		cmd = '../run.sh',
		hidden = true,
		display_name = 'Project Runner',
		direction = 'float',
		start_in_insert = false,
		close_on_exit = false,
		on_open = function(term)
			vim.cmd 'stopinsert'
			vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>lua _shutdown_current_project_run_sh_term()<CR>',
				{ noremap = true, silent = true })

			vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'w', '<cmd>close<CR>', { noremap = true, silent = true })
			vim.api.nvim_buf_set_keymap(term.bufnr, 'n', '<escape>', '<cmd>close<CR>', { noremap = true, silent = true })
		end,
		on_exit = function(term) shouldResetState = true end
	})
	function _quickrun_current_project_run_sh_term()
		shouldResetState = false
		current_project_run_sh.close_on_exit = true
		current_project_run_sh.display_name = 'Project Runner (Quickrun)'
		current_project_run_sh:shutdown()
		current_project_run_sh:open()
	end

	--If you start a quickrun then hide it, it maintains it's quickrun flags.
	--If you shut it down (with q or by closing the process) then use the toggle function; the new one will NOT be a quickrun window.
	function _toggle_current_project_run_sh_term()
		--If a quickrun was opened LAST usage, reset it's config.
		--However, if you last HID a quickrun one, then keep it quickrun.
		if shouldResetState then
			current_project_run_sh.close_on_exit = false
			current_project_run_sh.display_name = 'Project Runner'
			shouldResetState = false
		end
		current_project_run_sh:toggle()
	end

	function _shutdown_current_project_run_sh_term()
		shouldResetState = false
		current_project_run_sh:shutdown()
	end
end)

vim.cmd([[
	filetype plugin indent on
	augroup filetypedetect
    	au BufNewFile,BufRead *.asm,*.inc set ft=asm_ca65
	augroup END
]])

function _scroll_current_buffer(n)
	local cur = vim.api.nvim_win_get_cursor(0)
	local curY, curX = cur[1], cur[2]
	local targetY = math.min(math.max(1, curY + n), vim.api.nvim_buf_line_count(0))
	vim.api.nvim_win_set_cursor(0, { [1] = targetY, [2] = curX })
	-- vim.api.nvim_win_set_cursor(0, {[1] = 100, [2] = 5})
end

M.cmp_ls = U.Service({ { FT.CONF, "nvim-cmp" } }, {}, function()
	-- TODO: conditionally load luasnip realted stuff depending on features (requries plugin manager dependency feature registering)
	local ls = require 'luasnip'
	local ls_types = require 'luasnip.util.types'
	local luasnip = require 'luasnip'
	luasnip.config.setup({
		ext_opts = {
			[ls_types.choiceNode] = {
				active = { virt_text = { { Icons.item_kinds.Snippet, 'SnippetChoiceIndicator' } } },
				passive = { virt_text = { { Icons.item_kinds.Snippet, 'SnippetPassiveIndicator' } } }
			},
			[ls_types.insertNode] = {
				active = { virt_text = { { Icons.item_kinds.Snippet, 'SnippetInsertIndicator' } } },
				passive = { virt_text = { { Icons.item_kinds.Snippet, 'SnippetPassiveIndicator' } } }
			}
		},
	})

	-- require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/snips"})
	require("luasnip.loaders.from_snipmate").load()
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	local cmp = require 'cmp'
	-- cmp.event:on('confirmation_done', cmp_autopairs.on_confirm_done())

	---@diagnostic disable: missing-parameter
	cmp.setup {
		snippet = { expand = function(args) ls.lsp_expand(args.body) end },

		mapping = {
			['<PageDown>'] = cmp.mapping.scroll_docs(16),
			['<PageUp>']   = cmp.mapping.scroll_docs(-16),
			['<C-e>']      = cmp.mapping.abort(),
			['<Esc>']      = cmp.mapping.close(),
			--      ['<CR>']       = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
			['<Down>']     = function(fallback)
				cmp.close(); fallback()
			end,
			['<Up>']       = function(fallback)
				cmp.close(); fallback()
			end,

			--      ['<C-Space>']  = cmp.mapping.complete(),
			['<CR>']       = cmp.mapping(function(fallback)
				--        if true then fallback() end
				if cmp.get_active_entry() then
					cmp.confirm()
				elseif luasnip.jumpable() then
					while luasnip.expand_or_jumpable() do
						luasnip.jump(1)
					end
				else
					fallback()
				end
			end, { "i", "s" }),

			["<Tab>"]      = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- they way you will only jump inside the snippet region
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"]    = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
			['<C-Down>']   = cmp.mapping.select_next_item(),
			['<C-Up>']     = cmp.mapping.select_prev_item(),
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			-- { name = 'nvim_lua' },
			{ name = 'buffer' },
			-- { name = 'rg', option = { additional_arguments = '--smart-case --hidden', }},
			{ name = 'path' },
			-- { name = 'codeium' },
			-- { name = 'omni' },
			-- { name = 'spell' },
			-- { name = 'nvim_lsp_signature_help' },
			-- { name = 'digraphs' },
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = Icons.item_kinds[vim_item.kind] or ''
				return vim_item
			end
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			completion = {
				border = 'single',
				winhighlight = '',
				-- winhighlight = 'CursorLine:Normal',
			},
			documentation = {
				border = 'single',
				winhighlight = '',
			},
			-- scrollbar = '║',
		},
		completion = {
			get_trigger_characters = function(trigger_chars)
				local new_trigger_chars = {}
				for _, char in ipairs(trigger_chars) do
					if char ~= '>' then
						table.insert(new_trigger_chars, char)
					end
				end
				return new_trigger_chars
			end
		},
		experimental = {
			ghost_text = { hl_group = 'LspCodeLens' },
		}
	}

	cmp.setup.cmdline({ '/', '?' }, {
		-- mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' },
			-- { name = 'nvim_lsp_document_symbol' },
		}
	})

	cmp.setup.cmdline(':', {
		-- mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'path' },
			{ name = 'cmdline' },
		},
	})
end)


return M
