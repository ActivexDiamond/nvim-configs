local M = {}

M.a_vim = U.Service({{FT.CONF, 'a.vim'}}, {}, function()
end)

M.autopairs = U.Service({{FT.CONFG, 'autopairs'}}, {}, function()
	require("nvim-autopairs").setup {
	}
end)
return M
