--- entry point.
-- @module init
local a = test
-- all globals must be defined here

U = require 'utils'

Features = U.FeatureList():new()

-- TODO: make it the responsibility of the related service to instantiate events here
Events = {
	enter = U.Event():new(),
	refresh = U.Event():new(),
	clear = U.Event():new(),
	write = U.Event():new(),
	fold_update = U.Event():new(),
	install_post = U.Event():new(),
	install_pre = U.Event():new(),
	session_write_pre = U.Event():new(),
	plugin_setup = U.Event():new(),
}

local icon_sets = require 'icons'.icon_sets
Icons = {
	diagnostic_states = icon_sets.diagnostic_states.codicons,
	item_kinds = icon_sets.item_kinds.codicons,
	debugging = icon_sets.ui.codicons,
}

--Feature types enum.
FT = {
	PLUGIN = "PLUGIN",
	CONF = "CONF",
	KEY = "KEY",
	LANG = "LANG",
	LSP = "LSP",
	SESSION = "SESSION",
}

--Initializing logger.
log = require 'logger'.log

--Loading Modules.
require 'options'
require 'service_loader'

--Invoke enter event on VimEnter.
vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = Events.enter:wrap() })

--Custom filetypes.
vim.filetype.add({extension = {ln = 'factory'}})

--autochdir, but only on first run, NOT on every buffer change.
do
	local firstArg = vim.fn.argv()[1]
	--If a directory was passed, cd to it.
	if vim.fn.isdirectory(firstArg) ~= 0 then
		vim.cmd("cd " .. firstArg)
	else --If a file was passed, extract the path to it's directory instead, and cd to it.
		vim.cmd("cd %:p:h")
	end
end
