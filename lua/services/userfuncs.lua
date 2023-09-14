local M = {}

---Either call with `cmd, script`; `script` or nothing. 
---cmd defaults to "lua". Script defaults to current script.
vim.api.nvim_create_user_command("LRun", function(opts, a, b, buf)
	local cmd, script
	if b then
		cmd = a
		script = b
	else
		script = a or "%"
		cmd = "lua"
	end

	local name, fileType, lines = "mytitle", "text", {"hellothereworld", "how does it go", "pal"}
	local vimCmd = "silent! pedit! +setlocal\\ " ..
                  "buftype=nofile\\ " ..
                  "noswapfile\\ nonumber\\ " ..
                  "filetype=" .. fileType .. " " .. name
	vim.cmd(vimCmd)
	local bufNr = vim.fn.bufnr(name) 				---@diagnostic disable-line
	vim.api.nvim_buf_set_lines(bufNr, 0, -1, false, lines)

	--[[
	vim.cmd "silent! exe \"noautocmd botright pedit \".a:echo"
	vim.cmd "noautocmd wincmd P"
	vim.cmd "set buftype=nofile"
	vim.cmd "exe \"noautocmd r! \".a:echo"
	vim.cmd "noautocmd wincmd p"
	--]]
	-- vim.fn.term("lua -e 'print(\"hello\")'")

	-- for k, v in pairs(opts) do print(k, v)end
	-- print(a, b, buf)

end, {})

--[[
RunLua [target=currentfile] [cmd=lua]; runs current script as Lua. Opens terminal in split.
	If passed -t|--test will instead run target=current_folder and cmd=busted (basically just shorthand syntax.)
		Can still specifcy a custom cmd, target or extra options. If both custom target and cmd are passed then this defeats the purpose of the shorthand.

RunLove [target=current-workspace-dir] [cmd=love]; Goes up until it finds source folder with .luarc and runs it as love prj.
	Looks for either a prj-name/src/main.lua; a prj-name/prj-name/main.lua or a */main.lua. In that order!
	Opens terminal in split.
	If passed -t|--test wilth instead look prj-name/specs, prj-name/spec, prj-name/tests, prj-name/test and run busted on it.

Both can take:
	-q|--quick which runs in preview instead of split.
	-v|--vertical|--vsplit Which runs in vsplit.
	
	
--]]

return M
