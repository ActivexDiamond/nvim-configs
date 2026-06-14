local M = {}

--TODO: Make this read the LuaSnip config and parse the same snippets.
--Though parsing will be done in a minimal manner, only the TextMate format will be supported,
--	cursor positions will be ignored (as this is intended to be used for files created but not immediately opened in a buffer,
--	E.g. files created using neo-tree.

local snippets_templates = {
	lua = {
[[--Author:    Dulfiqar 'Active Diamond' H. Al-Safi
--Year:      (C) $YEAR
--File:      $FILENAME
]]
	},{
[[
]]
	}
}

function M.get_snippets(filetype)
	local snippets = snippets_templates[filetype]
	if type(snippets) ~= 'table' then return end
	if #snippets == 0 then return end

	return snippets
end

function M.get_snippet_with_prompt(filetype)
	local snippets = M.get_snippets(filetype)
	if not snippets then return end
	if #snippets == 1 then return snippets[1] end
	
	--TODO: Prompt the user to choose a snippet, and return their selection.
	return snippets[1]
end

function M.expand(snippet, tmp1)
	--TODO: Properly evalulate the snippet. Should expect a subset of LuaSnip's TextMate format.
	local str = snippet:gsub("$YEAR", os.date("%Y"))
	local str = str:gsub("$FILENAME", vim.fs.basename(tmp1))
	return str
end

return M
