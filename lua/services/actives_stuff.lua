local M = {}

--============================ Global Events ==============================
Events.enter:sub(function()
	--Update working directory on launch. Useful when calling nvim from a far-away directory.
--    local pwd = vim.fn.getcwd()
--    vim.api.nvim_set_current_dir(pwd)	vim.cmd("ch %:h")
end)

M.setup = U.Service(function()
	Events.plugin_setup()
end)

--============================ Minor / Minimal-Config Plugins ==============================
M.render_markdown = U.Service({ { FT.CONF, "render-markdown.nvim" } }, {}, function()
	require("render-markdown").setup({
		completions = { lsp = { enabled = true } },
		render_modes = { 'i', 'n', 't' },
		debounce = 0,
		heading = {
			position = 'inline',
			left_pad = 0.499,
		}
	})
end)

M.nvim_peekup = U.Service({ { FT.CONF, "nvim-peekup" } }, {}, function()
	local config = require("nvim-peekup.config")
	config.on_keystroke["delay"] = ""
end)

vim.cmd([[
	filetype plugin indent on
	augroup filetypedetect
    	au BufNewFile,BufRead *.asm,*.inc set ft=asm_ca65
	augroup END
]])

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

--============================ Global Functions ==============================
--A leading underscore means it is intended to be used through a keybind; not directly in the editor / CMD window.
function _scroll_current_buffer(n)
	local cur = vim.api.nvim_win_get_cursor(0)
	local curY, curX = cur[1], cur[2]
	local targetY = math.min(math.max(1, curY + n), vim.api.nvim_buf_line_count(0))
	vim.api.nvim_win_set_cursor(0, { [1] = targetY, [2] = curX })
	-- vim.api.nvim_win_set_cursor(0, {[1] = 100, [2] = 5})
end

--============================ User Commands ==============================
function toggle_virtual_lines_for_diagnostics()
	local current = vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({virtual_lines = not current})
end
vim.api.nvim_create_user_command("Tvd", toggle_virtual_lines_for_diagnostics,
		{desc="Toggles virtual lines being used to display diagnostics."})

--============================ nvim-skel ==============================
M.skel_nvim = U.Service({ { FT.CONF, 'skel-nvim' } }, {}, function()
	require("skel-nvim").setup{
		skel_enabled = false,
		apply_skel_for_empty_file = false,

		mappings = {
			['*.*'] = "short_credit.skel",

			--TODO: Templates for many different file types.
			--['*.lua']   = "lua.skel",

			--FIXME: My config seems to break skel's multi-option templplates.	
			--['LICENSE'] = {"license.mit.skel", "license.gpl.skel" }
		}
	}
end)

	--============================ nvim-navbuddy ==============================
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

--============================ outline.nvim ==============================
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
		relative_width = false,
		width = 120,
		height = 95,
		border = 'double',
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
			lua = {'Variable', exclude = true},
			html = {'Property', 'Variable', 'Field', 'Class', exclude = true},
		},
	},
}
--FIXME: Make Outline open at the correct time.
--vim.api.nvim_create_autocmd({ "BufEnter" }, {
--	callback = function()
--		vim.cmd("OutlineOpen")
--	end,
--})

--============================ toggleterm.nvim ==============================
M.toggle_term = U.Service({ { FT.CONF, "toggleterm.nvim" } }, {}, function()
	require 'toggleterm'.setup {
		--FIXME: This should go to lua/services/bind.lua
		open_mapping = '<leader>\\',

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

	local runnerPath = vim.fn.findfile("run.sh", ";")
	local shouldResetState
	local current_project_run_sh = Terminal:new({
		cmd = ("cd $(dirname %s) && echo $PWD && %s && exit"):format(runnerPath, runnerPath),
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

--============================ nvim-cmp ==============================
M.cmp_ls = U.Service({ { FT.CONF, "nvim-cmp" } }, {}, function()
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

	--TODO: Factor out LuaSnip configs into it's own function.
	ls.env_namespace("EXTRAS", {vars = {
		AUTHOR_REAL_NAME = "Dulfiqar H. Al-Safi",
		AUTHOR_USERNAME = "Active Diamond",
		AUTHOR_VERBOSE_NAME = "Dulfiqar 'Active Diamond' H. Al-Safi",
		RANDOM = function() return math.random() end,
	}})
	--This can be indexed by any string, and will automatically check the OS ENV for it.
	--Example: $SYS_USER or $SYS_HOME
	ls.env_namespace("SYS", {vars=os.getenv})

	-- require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/snips"})
	require("luasnip.loaders.from_snipmate").load()
	local cmp_autopairs = require('nvim-autopairs.completion.cmp')
	local cmp = require 'cmp'
	-- cmp.event:on('confirmation_done', cmp_autopairs.on_confirm_done())

	--Got removed from nvim-cmp at some point, so add it back in.
	local has_words_before = function()
		if vim.bo[0].buftype == 'prompt' then
			return false
		end
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
	end

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
					--FIXME: Is this what sometimes breaks newlines?
					--fallback()

					--Temp fix, seeems to break other stuff.
					cmp.close(); fallback()
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
				max_width = 0,
				max_height = 0,
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

--============================ ccc.nvim ==============================
--FIXME: This causes a stackoverflow. Seems to have to do with ccc.setup trying to init an lsp for ts_ls or something?
-- M.ccc = U.Service({ { FT.CONF, "ccc.nvim" } }, {}, function()
function M.ccc_opts()
	local ccc = require('ccc')

	local opts = {
		preserve = true,
		-- point_char = 'O',
		default_color = "#7f7f7f",
		mappings = {
			['<right>'] = ccc.mapping.increase1,
			['<S-right>'] = ccc.mapping.increase5,
			['<C-right>'] = ccc.mapping.increase10,
			['<left>'] = ccc.mapping.decrease1,
			['<S-left>'] = ccc.mapping.decrease5,
			['<C-left>'] = ccc.mapping.decrease10,
			['<C-S-right>'] = ccc.mapping.set100,
			['<C-S-left>'] = ccc.mapping.set0,
		},
		pickers = {
			ccc.picker.hex,
			ccc.picker.css_rgb,
			ccc.picker.css_hsl,
			ccc.picker.css_hwb,
			ccc.picker.css_lab,
			ccc.picker.css_lch,
			ccc.picker.css_oklab,
			ccc.picker.css_oklch,
			ccc.picker.ansi_escape(),
		},
		highlighter = {
			auto_enable = true,
		}
	}

	--Draw big colored rect next to it. Gotten from: https://github.com/uga-rosa/ccc.nvim/issues/13
	do
		local id = "ccc-preview"
		local ns = vim.api.nvim_create_namespace(id)
		local pwin
		vim.api.nvim_create_autocmd("User", {
			desc = id,
			pattern = "CccColorChanged",
			group = vim.api.nvim_create_augroup(id, { clear = true }),
			callback = function(event)
				if vim.g.ccc_color == "" then return end

				if not pwin then
					local cwin = vim.fn.win_findbuf(event.buf)[1]

					local pbuf = vim.api.nvim_create_buf(false, true)
					vim.api.nvim_set_option_value("modifiable", false, { buf = pbuf })
					vim.api.nvim_set_option_value("buftype", "nofile", { buf = pbuf })
					vim.api.nvim_set_option_value("filetype", "ccc-preview", { buf = pbuf })

					pwin = vim.api.nvim_open_win(pbuf, false, {
						relative = "win",
						win = cwin,

						row = -2,
						col = vim.api.nvim_win_get_width(cwin) + 1,

						width = 12,
						height = 5,

						border = "rounded",
						style = "minimal",
						focusable = false,
					})
					local closeColorWindow = {
						pattern = tostring(cwin),
						once = true,
						callback = function()
							vim.api.nvim_buf_delete(pbuf, { force = true })
							vim.api.nvim_win_close(vim.fn.win_getid(pwin), true)
							pwin = nil
						end,
					}
					--FIXME: Color window lingers around if CccPick loses focus instead of confirming/closing.
					vim.api.nvim_create_autocmd("WinClosed", closeColorWindow)
					-- vim.api.nvim_create_autocmd("WinLeave", closeColorWindow)
				end

				vim.api.nvim_set_hl(ns, "NormalFloat", { bg = vim.g.ccc_color })
				vim.api.nvim_win_set_hl_ns(pwin, ns)
			end,
		})
	end
	return opts
end

return M
