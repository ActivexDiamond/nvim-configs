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
  M.key {'<C-s>',             '<ESC><CMD>wa<CR>', mode = 'x i'}
  M.key {'<C-s>',             '<CMD>wa<CR>', mode = 'n'}
  M.key {'<C-z>',             function() vim.cmd.undo() end, mode = 'n x i'}
  M.key {'<C-c>',             function() vim.cmd.quit() end, mode = 'n x i'}
  -- M.key {'<A-c>',             function() vim.cmd.bdelete() end, mode = 'n v i'}
--  M.key {'<C-q>',             function() vim.cmd.quitall() end, mode = 'n x i'}
  -- spell
  M.key {'<leader>s',         Lang.toggle_spell}
  -- M.key {'<C-a>',            ':%'}
  -- quick fix list
  -- M.key {'<S-Up>',            '<CMD>cprevious<CR>'}
  -- M.key {'<S-Down>',          '<CMD>cnext<CR>'}
  -- filter
  -- M.key {'==',                '==_'}
  -- M.key {'=',                 '=gv_', mode = 'x'}
  -- switch between last 2 windows
  -- M.key {'<leader>y',           '<C-w>p'}
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
--  M.key {'<leader>p',         PluginManager.sync }
  
  	-- lsp
  M.key {'<leader>r',         Lsp.rename }

  M.key {'<leader>a',         Lsp.hover }
  M.key {'<leader>d',         Lsp.references }
  M.key {'<leader>D',         Lsp.definition }

  M.key {'<leader>c',         Lsp.code_action }
  M.key {'<leader>v',         Lsp.diags_list }
  M.key {'<leader>V',        Lsp.diags_hover }

  M.key {'<leader>n',        '<CMD>Navbuddy<CR>' }
  M.key {'<leader>]',        '<CMD>OutlineOpen<CR>' }
  M.key {'<C-space>',        '<CMD>OutlineFocus<CR>', mode = 'n i v'}


  M.key {'<leader>l',        '<CMD>lua _toggle_lazygit_term()<CR>' }
  M.key {'<C-l>', 			 '<CMD>lua _toggle_current_project_run_sh_term()<CR>', mode = 'n i v'}
  M.key {'<C-;>', 			 '<CMD>lua _quickrun_current_project_run_sh_term()<CR>', mode = 'n i v'}

  --These don't seem to work, in Lua at least.
--  M.key {'<leader>D',         Lsp.toggle_diags }

  -- terminal smart escape
  M.key {'<Esc>',             TermSmartEsc, mode = 't', opts = { expr = true }}

  -- PLUGINS

  local telescope = require 'telescope.builtin'
  M.key {'<C-e>',             function() telescope.buffers{ignore_current_buffer=true, sort_mru=true, } end , mode = 'i n v'}

  if Features:has(FT.CONF, 'neo-tree.nvim') then
    M.key {'<C-a>',             '<ESC><CMD>Neotree<CR>', mode = 'i n'}
  end

  if Features:has(FT.CONF, 'fold-cycle.nvim') then
  	local fc = require 'fold-cycle'  		
    M.key {'za',                function() fc.toggle_all() Events.fold_update() end }
    M.key {'z<Right>',          function() fc.open() Events.fold_update() end }
    M.key {'z<Left>',           function() fc.close() Events.fold_update() end }
    M.key {'z<Down>',           function() fc.open_all() Events.fold_update() end }
    M.key {'z<Up>',             function() fc.close_all() Events.fold_update() end }
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

  if Features:has(FT.CONF, 'telescope.nvim') then
    M.key {'<leader><CR>',      '<CMD>Telescope resume<CR>'}
    M.key {'<leader>f',         '<CMD>Telescope find_files<CR>'}
    M.key {'<leader>g',         '<CMD>Telescope live_grep<CR>'}
    M.key {'<leader>t',         '<CMD>Telescope<CR>'}
  end

  -- neotest
  M.key {'<leader>\\',         '<CMD>Neotree toggle<CR>'}

  if Features:has(FT.CONF, 'vim-illuminate') then
    M.key {'r<Right>',          function() require('illuminate').goto_next_reference() end}
    M.key {'r<Left>',           function() require('illuminate').goto_prev_reference() end}
  end

  -- M.key {'<C-Right>', '<Plug>luasnip-next-choice'}
  -- imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  -- smap <si-lent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  --Active's stuff
  M.key {'<C-d>', '<C-o>"_dd',         mode = 'i v'}
  M.key {'<C-d>', '"_dd',              mode = 'n'}

  --if Features:has(FT.CONF, 'a.vim') then
    M.key {'<C-x>', '<CMD>A<CR>',    mode = 'n i v'}           --x for eXtension (c/h/hpp/cpp/etc...)
    M.key {'xb',    '<CMD>A<CR>',    mode = 'n'}               --b for Buffer.
    M.key {'xv',    '<CMD>AV<CR>',   mode = 'n'}               --for Vsplit.
  --end

	--Smartword mappings.
--    M.key {'w',    '<Plug>(smartword-w)',   mode = 'n v --    M.key {'b',    '<Plug>(smartword-b)',   mode = 'n v '}
--    M.key {'e',    '<Plug>(smartword-e)',   mode = 'n v '}
--    M.key {'ew',    '<Plug>(smartword-eg)',   mode = 'n v '}

	--Add newline above/below (respectively) currently selected line.
    M.key {'<M-a>',    '<CMD>call append(line(".")-1,   repeat([""], v:count1))<CR>',   mode = 'n i'}
    M.key {'<M-s>',    '<CMD>call append(line("."),   repeat([""], v:count1))<CR>',   mode = 'n i'}

	--Call the LSP's code_action function.
    M.key {'<M-z>',    '<CMD>lua vim.lsp.buf.code_action()<CR>',   mode = 'n i x'}

	-- word/WORD DELETION
	
    --Delete the word before the cursor, while preserving your mode and set to "b register.
    M.key {'<C-w>',    '<C-o>"bdb',   mode = 'i'}
    M.key {'<C-w>',    '"bdb',   mode = 'n'}

    --Delete the word after the cursor, while preserving your mode and set to "w register. (Opposite of the CTRL-w)
    M.key {'<C-Bslash>',    '<C-o>"wdw',   mode = 'i'}
    M.key {'<C-Bslash>',    '"wdw',   mode = 'n'}

	--Delete the word under the cursor, and return to the previous mode.
	--FIXME: This didn't work with smartword motions, as the others did.
    M.key {'<C-BS>',    '<C-o>"udaw',   mode = 'i'}
    M.key {'<C-BS>',    '"udaw',   mode = 'n'}

    -- All of these are the same as the above, but with WORD instead of word.
    --Delete the WORD before the cursor, while preserving your mode and set to "b register.
	M.key {'<M-w>',    '<C-o>"bdB',   mode = 'i'}
    M.key {'<M-w>',    '"bdB',   mode = 'n'}

    --Delete the WORD after the cursor, while preserving your mode and set to "w register. (Opposite of the CTRL-w)
    M.key {'<M-Bslash>',    '<C-o>"wdW',   mode = 'i'}
    M.key {'<M-Bslash>',    '"wdW',   mode = 'n'}

	--Delete the WORD under the cursors, and return to the previous mode.
    M.key {'<M-BS>',    '<C-o>"udaW',   mode = 'i'}
    M.key {'<M-BS>',    '"udaW',   mode = 'n'}

    --Introduce <BS> functionality into nmode. Note that <Del> already works as expected (FIXME: Unless you Del while at EOL, then it starts going backwards).
    M.key {'<BS>',    'X',   mode = 'n'}

    --Save all and exit.
    M.key {'<F3>',    '<CMD>xa<CR>',   mode = 'n i v x t'}
	--Quit without saving anything. Fails if any unsaved changes exist.
    M.key {'<F4>',    '<CMD>qa<CR>',   mode = 'n i v x t'}
	--Force quit without saving anything. Note that: <F16> == <S-F4>
    M.key {'<F16>',    '<CMD>qa!<CR>',   mode = 'n i v x t'}

    M.key {'<<CR>>',    '@="m`o<C-V><Esc>``"<CR>',   mode = 'n v'}
    
    --Split resizing
    M.key {'<C-S-lt>',    '<CMD>resize -5<CR>',   mode = 'n'}
    M.key {'<C-S->>',    '<CMD>resize +5<CR>',   mode = 'n'}
    M.key {'<C-,>',    '<CMD>vertical resize -5<CR>',   mode = 'n'}
    M.key {'<C-.>',    '<CMD>vertical resize +5<CR>',   mode = 'n'}

	--Window movement
    M.key {'<A-Left>',    '<C-w>h',   mode = 'n'}
    M.key {'<A-Right>',    '<C-w>l',   mode = 'n'}
    M.key {'<A-Up>',    '<C-w>k',   mode = 'n'}
    M.key {'<A-Down>',    '<C-w>j',   mode = 'n'} 

    M.key {'<A-Left>',    '<C-o><C-w>h',   mode = 'i'}
    M.key {'<A-Right>',    '<C-o><C-w>l',   mode = 'i'}
    M.key {'<A-Up>',    '<C-o><C-w>k',   mode = 'i'}
    M.key {'<A-Down>',    '<C-o><C-w>j',   mode = 'i'}

    M.key {'<S-Up>',    '<CMD>lua _scroll_current_buffer(-10)<CR>',   mode = 'i n'}
    M.key {'<S-Down>',    '<CMD>lua _scroll_current_buffer(10)<CR>',   mode = 'i n'}

  if Features:has(FT.CONF, 'mini.nvim') then
    -- mini.bufremove
    M.key {'<A-c>',             function() require 'mini.bufremove'.delete() end, mode = 'n x i'}

    -- mini.move
    M.key {'<Tab>',             function() require 'mini.move'.move_line('right') end, mode = 'n' }
    M.key {'<S-Tab>',           function() require 'mini.move'.move_line('left') end, mode = 'n' }
    M.key {'<Tab>',             function() require 'mini.move'.move_selection('right', {reindent_linewise = false}) end, mode = 'v' }
    M.key {'<S-Tab>',           function() require 'mini.move'.move_selection('left', {reindent_linewise = false}) end, mode = 'v' }

    M.key {'<C-Up>',            function() require 'mini.move'.move_line('up') end, mode = 'i n' }
    M.key {'<C-Down>',         function() require 'mini.move'.move_line('down') end, mode = 'i n' }
    M.key {'<C-Up>',            function() require 'mini.move'.move_selection('up') end, mode = 'x' }
    M.key {'<C-Down>',          function() require 'mini.move'.move_selection('down') end, mode = 'x' }
  end


end)
--<F16> = <S-F4>

return M
