local M = {}

M.setup = U.Service(function()
  --TODO: Figure out what this does.
  Events.plugin_setup()
end)

 M.a_vim = U.Service({{FT.CONF, 'a.vim'}}, {}, function()
 end)

M.autopairs = U.Service({{FT.CONF, 'autopairs'}}, {}, function()
	--require 'nvim-autopairs'.setup()
end)

M.todo_comments = U.Service({{FT.CONF, 'todo-comments'}}, {}, function()
	--TODO: Personalise this config.
	require 'todo-comments'.setup {
		highlight = {
			keyword = "bg",
		}
	}
end)

vim.cmd([[
	filetype plugin indent on
	augroup filetypedetect
    	au BufNewFile,BufRead *.asm,*.inc set ft=asm_ca65
	augroup END
]])
return M
