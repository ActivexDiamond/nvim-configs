--- defines vanilla and (a much as possible) plugin keybinds
-- @module bind
local M = {}

M.keys = {}

-- a keymap object is {lhs, rhs, opts = {}, mode = string}
M.key = U.Service(function(keymap)
  keymap.opts = vim.tbl_deep_extend('force', keymap.opts or {}, { noremap = true, silent = true })
  ---@diagnostic disable-next-line: param-type-mismatch
  keymap.mode = keymap.mode and vim.split(keymap.mode, ' ', {}) or 'n'

  vim.keymap.set(keymap.mode, keymap[1], keymap[2], keymap.opts)
  table.insert(M.keys, keymap)
end)

M.setup = U.Service(function()
  -- LEADER KEY
  M.key({'<Space>', '<Nop>', mode = ''})
  vim.g.mapleader = ' '

  -- DISABLES
  -- ctrl-x submode, c-p and c-n
  M.key {'<C-x>',            '<Nop>', mode = 'i'}

  -- BASE
  -- write, undo, quit
  Events.write:sub(vim.cmd.write)
  Events.write:sub(vim.cmd.stopinsert)
  M.key {'<C-s>',             function() Events.write() end, mode = 'n x i'}
  M.key {'<C-z>',             function() vim.cmd.undo() end, mode = 'n x i'}
  M.key {'<C-c>',             function() vim.cmd.quit() end, mode = 'n x i'}
  -- M.key {'<A-c>',             function() vim.cmd.bdelete() end, mode = 'n v i'}
  M.key {'<C-q>',             function() vim.cmd.quitall() end, mode = 'n x i'}
  -- page shift up/down, select all
  M.key {'<C-Up>',            '<C-y>k'}
  M.key {'<C-Down>',          '<C-e>j'}
  -- spell
  M.key {'<leader>s',         Lang.toggle_spell}
  -- M.key {'<C-a>',            ':%'}
  -- quick fix list
  M.key {'<S-Up>',            '<CMD>cprevious<CR>'}
  M.key {'<S-Down>',          '<CMD>cnext<CR>'}
  -- filter
  M.key {'==',                '==_'}
  M.key {'=',                 '=gv_', mode = 'x'}
  -- switch between last 2 windows
  M.key {'<A-Tab>',           '<C-w>p'}
  -- make x delete without copying
  -- M.key {'x',                '"_x', mode = 'x n'}
  M.key {'X',                 '"_x', mode = 'x n'}
  -- preserve cursor position after a yank
  M.key {'y',                 "ygv<ESC>", mode = 'x'}
  -- make Y copy to end of line in normal mode
  M.key {'Y',                 'y$'}
  -- copy and retain visual selection in visual mode
  M.key {'Y',                 'ygv', mode = 'x'}
  -- go to end after a join
  M.key {'J',                 'J$'}
  -- split (opposite of J)
  M.key {'S',                 'T hr<CR>k$'}
  -- swap # and *
  M.key {'*',            '#'}
  M.key {'#',            '*'}

 	
  -- open man pages in new tabs
  -- M.key {'K',                 ':tab Man<CR>'}
  -- zt and zb with arrows
  -- M.key {'z<Up>',             'zt'}
  -- M.key {'z<Down>',           'zb'}
  -- center line after n/N
  -- M.key {'n',                'nzzzv'}
  -- M.key {'N',                'Nzzzv'}
  -- refresh action
  -- venom.events.refresh:sub('mkview')
  -- venom.events.refresh:sub('e')
  -- venom.events.refresh:sub('loadview')
  -- M.key {'<F5>',              function() venom.events.refresh() end}
  -- clear action
  -- venom.actions.clear:sub [[let @/ = ""]]
  Events.clear:sub [[noh]]
  Events.clear:sub(U.clear_prompt)
  M.key {'<C-l>',             function() Events.clear() end}
  M.key {'<C-l>',             '<ESC>', mode = 'i'}
  -- undo breakpoints
  local undo_break_points = {',', '.', '!', '?', '-'}
  for _, break_point in pairs(undo_break_points) do
    M.key {break_point,       break_point..'<C-g>u', mode = 'i'}
  end
  -- goto and display to nex/prev lsp diagnositc
  M.key {'<leader><Left>',           function() vim.diagnostic.goto_prev({ float = false }) end}
  M.key {'<leader><Right>',          function() vim.diagnostic.goto_next({ float = false }) end}
  -- tabs
--  M.key {'<C-t>',             vim.cmd.tabnew}
  -- buffers
  M.key {'<A-Right>',         vim.cmd.bnext}
  M.key {'<A-Left>',          vim.cmd.bprevious}
  for i, label in ipairs(Buffers.labels) do
    M.key {'<A-'..label..'>',      function() Buffers.buf_switch_by_label(label) end}
  end

  -- MOTIONS
  M.key {'aa',                ':<c-u>normal! ggVG<CR>', mode = 'o'}

  -- TESTING
  -- M.key {'<A-z>',            function() vim.notify("hi friend") end}

  -- old
  -- shifting line
  -- M.key {'<A-Down>',         '<CMD>m .+1<CR>'}
  -- M.key {'<A-Up>',           '<CMD>m .-2<CR>'}
  -- M.key {'<A-Down>',         '<CMD>m .+1<CR><ESC>i', mode = 'i'}
  -- M.key {'<A-Up>',           '<CMD>m .-2<CR><ESC>i', mode = 'i'}
end)

-- TODO load each conditionally depending on registered features
M.setup_plugins = U.Service(function()
  -- Builtins
  -- open uri under cursor
  M.key {'gx',                OpenURIUnderCursor }
  -- plugin manager sync
  M.key {'<leader>p',         PluginManager.sync }
  -- lsp
  M.key {'<leader>D',         Lsp.toggle_diags }
  M.key {'<leader>r',         Lsp.rename }
  M.key {'<leader>R',         Lsp.references }
  M.key {'<leader>d',         Lsp.definition }
  M.key {'<leader>C',         Lsp.code_action }
  M.key {'<leader>v',         Lsp.hover }
  M.key {'<leader>dl',        Lsp.diags_list }
  M.key {'<leader>dv',        Lsp.diags_hover }
  -- terminal smart escape
  M.key {'<Esc>',             TermSmartEsc, mode = 't', opts = { expr = true }}

  -- PLUGINS
--  if Features:has(FT.CONF, 'nvim-toggleterm.lua') then
    M.key {'<M-]>',           '<CMD>ToggleTerm<CR>', mode = 'n'}
    M.key {'<M-]>',           [[<C-\><C-n><CMD>ToggleTerm<CR>]], mode = 't'}
--  end

  if Features:has(FT.CONF, 'nvim-tree.lua') then
    M.key {'<C-e>',             '<CMD>NvimTreeToggle<CR>', mode = 'i n'}
  end

  if Features:has(FT.CONF, 'neo-tree.nvim') then
    M.key {'<C-e>',             '<CMD>Neotree buffers float<CR>', mode = 'i n'}
    M.key {'<C-a>',             '<CMD>Neotree<CR>', mode = 'i n'}
    M.key {'<C-A-e>',             '<CMD>Neotree close<CR>', mode = 'i n'}
	M.key {'<tab>', function(state)
  	  state.commands["open"](state)
  	  vim.cmd("Neotree reveal")

	end}
  end

  if Features:has(FT.CONF, 'fold-cycle.nvim') then
    M.key {'za',                function() require 'fold-cycle'.toggle_all() Events.fold_update() end }
    M.key {'z<Right>',          function() require 'fold-cycle'.open() Events.fold_update() end }
    M.key {'z<Left>',           function() require 'fold-cycle'.close() Events.fold_update() end }
    M.key {'z<Down>',           function() require 'fold-cycle'.open_all() Events.fold_update() end }
    M.key {'z<Up>',             function() require 'fold-cycle'.close_all() Events.fold_update() end }
  end

  if Features:has(FT.CONF, 'fold-preview.nvim') then
    M.key {'zq',                function() require 'fold-preview'.toggle_preview() end}
  end

  if Features:has(FT.CONF, 'gitsigns.nvim') then
    M.key {'gr',                '<CMD>Gitsigns reset_hunk<CR>'}
    M.key {'gr',                function()
      require 'gitsigns'.reset_hunk({ vim.fn.line('v'), vim.fn.getpos('.')[2] })
      -- TODO: find a better way to switch back to normal mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 't', false)
    end, mode = 'x'}
    M.key {'gp',                '<CMD>Gitsigns preview_hunk<CR>'}
    M.key {'gb',                '<CMD>Gitsigns blame_line<CR>'}
    M.key {'gd',                '<CMD>Gitsigns diffthis<CR>'}
    M.key {'gs',                '<CMD>Gitsigns stage_hunk<CR>'}
    M.key {'gs',                function()
      require 'gitsigns'.stage_hunk({ vim.fn.line('v'), vim.fn.getpos('.')[2] })
      -- TODO: find a better way to switch back to normal mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 't', false)
    end, mode = 'v' }
    M.key {'gu',                '<CMD>Gitsigns undo_stage_hunk<CR>'}
    M.key {'g<Left>',           '<CMD>Gitsigns prev_hunk<CR>zz'}
    M.key {'g<Right>',          '<CMD>Gitsigns next_hunk<CR>zz'}
  end

  if Features:has(FT.CONF, 'mini.nvim') then
    -- mini.bufremove
    M.key {'<A-c>',             function() require 'mini.bufremove'.delete() end, mode = 'n x i'}
    -- mini.move
    M.key {'<Tab>',             function() require 'mini.move'.move_line('right') end, mode = 'n' }
    M.key {'<S-Tab>',           function() require 'mini.move'.move_line('left') end, mode = 'n' }
    M.key {'<Tab>',             function() require 'mini.move'.move_selection('right') end, mode = 'x' }
    M.key {'<S-Tab>',           function() require 'mini.move'.move_selection('left') end, mode = 'x' }
    M.key {'<A-Down>',          function() require 'mini.move'.move_line('down') end, mode = 'n' }
    M.key {'<A-Up>',            function() require 'mini.move'.move_line('up') end, mode = 'n' }
    M.key {'<A-Down>',          function() require 'mini.move'.move_selection('down') end, mode = 'x' }
    M.key {'<A-Up>',            function() require 'mini.move'.move_selection('up') end, mode = 'x' }
  end
  
  if Features:has(FT.PLUGIN, 'mason.nvim') then
    M.key {'<leader>l',         '<CMD>Mason<CR>'}
  end

  if Features:has(FT.CONF, 'telescope.nvim') then
    M.key {'<leader><CR>',      '<CMD>Telescope resume<CR>'}
    M.key {'<leader>f',         '<CMD>Telescope find_files<CR>'}
    M.key {'<leader>g',         '<CMD>Telescope live_grep<CR>'}
  end

  -- neotest
  -- M.key {'<leader>t',         '<CMD>NeotestToggleTree<CR>'}

  if Features:has(FT.CONF, 'vim-illuminate') then
    M.key {'r<Right>',          function() require('illuminate').goto_next_reference() end}
    M.key {'r<Left>',           function() require('illuminate').goto_prev_reference() end}
  end
  
  if Features:has(FT.CONF, 'rest.nvim') then
    M.key {'h<CR>',             '<Plug>RestNvim'}
  end

  -- M.key {'<C-Right>', '<Plug>luasnip-next-choice'}
  -- imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  -- smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  --Active's stuff
  M.key {'<C-d>', '<C-o>"_dd',         mode = 'i v'}
  M.key {'<C-d>', '"_dd',              mode = 'n'}

  --if Features:has(FT.CONF, 'a.vim') then
    M.key {'<C-x>', '<CMD>A<CR>',    mode = 'n i x'}           --x for eXtension (c/h/hpp/cpp/etc...)
    M.key {'xb',    '<CMD>A<CR>',    mode = 'n'}               --b for Buffer.
    M.key {'xv',    '<CMD>AV<CR>',   mode = 'n'}               --for Vsplit.
  --end

	--Smartword mappings.
    M.key {'w',    '<Plug>(smartword-w)',   mode = 'n v '}
    M.key {'b',    '<Plug>(smartword-b)',   mode = 'n v '}
    M.key {'e',    '<Plug>(smartword-e)',   mode = 'n v '}
    M.key {'ew',    '<Plug>(smartword-eg)',   mode = 'n v '}

	--Add newline after/before (respectively) currently selected line.
    M.key {'<M-a>',    '<CMD>call append(line("."),   repeat([""], v:count1))<CR>',   mode = 'n i'}
    M.key {'<M-s>',    '<CMD>call append(line(".")-1,   repeat([""], v:count1))<CR>',   mode = 'n i'}

	--Call the LSP's code_action function.
    M.key {'<M-z>',    '<CMD>lua vim.lsp.buf.code_action()<CR>',   mode = 'n i x'}

	-- word/WORD DELETION
	
    --Delete the word before the cursor, while preserving your mode and set to "b register.
    M.key {'<C-BS>',    '<C-o>"bdb',   mode = 'i'}
    M.key {'<C-BS>',    '"bd<Plug>(smartword-b)',   mode = 'n'}

    --Delete the word after the cursor, while preserving your mode and set to "w register. (Opposite of the old CTRL-w)
    M.key {'<C-Bslash>',    '<C-o>"wd<Plug>(smartword-w)',   mode = 'i'}
    M.key {'<C-Bslash>',    '"wd<Plug>(smartword-w)',   mode = 'n'}

	--Delete the word under the cursors, and return to the previous mode.
	--FIXME: This didn't work with smartword motions, as the others did.
    M.key {'<C-w>',    '<C-o>"udaw',   mode = 'i'}
    M.key {'<C-w>',    '"udaw',   mode = 'n'}

    -- All of these are the same as the above, but with WORD instead of word.
    --Delete the WORD before the cursor, while preserving your mode and set to "b register.
	M.key {'<M-BS>',    '<C-o>"bdB',   mode = 'i'}
    M.key {'<M-BS>',    '"bdB',   mode = 'n'}

    --Delete the WORD after the cursor, while preserving your mode and set to "w register. (Opposite of the old CTRL-w)
    M.key {'<M-Bslash>',    '<C-o>"wdW',   mode = 'i'}
    M.key {'<M-Bslash>',    '"wdW',   mode = 'n'}


	--Delete the WORD under the cursors, and return to the previous mode.
    M.key {'<M-w>',    '<C-o>"udaW',   mode = 'i'}
    M.key {'<M-w>',    '"udaW',   mode = 'n'}

    --Introduce <BS> functionality into nmode. Note that <Del> already works as expected (FIXME: Unless you Del while at EOL, then it starts going backwards).
    M.key {'<BS>',    'X',   mode = 'n'}

    --Save all and exit.
    M.key {'<F3>',    '<CMD>xa<CR>',   mode = 'n i v x t'}
	--Quit without saving anything. Fails if any unsaved changes exist.
    M.key {'<F4>',    '<CMD>qa<CR>',   mode = 'n i v x t'}
	--Force quit without saving anything. Note that: <F16> == <S-F4>
    M.key {'<F16>',    '<CMD>qa!<CR>',   mode = 'n i v x t'}

end)
--<F16>

return M
