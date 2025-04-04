--- invokes various services in order.
-- @module service_loader
Buffers = require 'services.buffers'
PluginManager = require 'plugin_manager'
Sessions = require 'services.sessions'
Bind = require 'services.bind'
Misc = require 'services.misc'
Plugins = require 'services.plugins'
Lang = require 'services.lang'
Lsp = require 'services.lsp'
Statusbar = require 'services.statusbar'
UserFuncs = require 'services.userfuncs'
ActivesStuff = require 'services.actives_stuff'

---Some OS-specific stuff.
local uname = vim.loop.os_uname()
local OS = uname.sysname

local IS_MAC = OS == 'Darwin'
local IS_LINUX = OS == 'Linux'
local IS_WINDOWS = OS:find 'Windows' and true or false
local IS_WSL = IS_LINUX and uname.release:find 'Microsoft' and true or false

--TODO: Figure out which one is better for windows.
local FZF_WINDOWS_BUILD_CMD =
'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
--local FZF_WINDOWS_BUILD_CMD = 'mkdir build && gcc -O3 -Wall -Werror -fpic -std=gnu99 -shared src/fzf.c -o build/libfzf.dll'
local FZF_WINDOWS_UNIX_BUILD_CMD = 'make'

local FZF_BUILD_CMD = IS_WINDOWS and FZF_WINDOWS_BUILD_CMD or FZF_UNIX_BUILD_CMD

local p = {
	plenary = 'nvim-lua/plenary.nvim',
	devicons = 'kyazdani42/nvim-web-devicons',
	treesitter = 'nvim-treesitter/nvim-treesitter',
	dap = 'mfussenegger/nvim-dap',
	gitsigns = 'lewis6991/gitsigns.nvim',
	nui = 'MunifTanjim/nui.nvim',
	lspconfig = 'neovim/nvim-lspconfig',
}
local plugins = {
	-- LSP: language server protocol related
	{
		p.lspconfig,
		dependencies = {
			'SmiteshP/nvim-navbuddy',
			dependencies = {
				'SmiteshP/nvim-navic',
				'MunifTanjim/nui.nvim',
			},
			--      opts = { lsp = { auto_attach = true } },
		},
	},

	{
		'jose-elias-alvarez/null-ls.nvim',
		dependencies = p.plenary,
	},
	{
		'williamboman/mason.nvim',
		dependencies = {
			p.lspconfig,
			'williamboman/mason-lspconfig.nvim',
			'jayp0521/mason-null-ls.nvim',
		},
	},
	{ 'mfussenegger/nvim-jdtls' },
	{
		'b0o/schemastore.nvim',
		dependencies = p.lspconfig,
	},
	{
		'folke/neodev.nvim',
		dependencies = p.lspconfig,
	},
	{
		'Mofiqul/trld.nvim',
		config = function()
			Events.plugin_setup:sub(Plugins.trld)
		end
	},

	{ 'Issafalcon/lsp-overloads.nvim' },
	-- LANG: treesitter and language specific plugins
	---[[
	{
		p.treesitter,
		build = ':TSUpdate',
	},
	--FIXME: Nice plugin but can't currently use it due to annoying stacktraceback. Can't even find where it's logged to fully/properly read it!
	-- { 'JoosepAlviste/nvim-ts-context-commentstring',
	-- dependencies = p.treesitter,
	-- },
	--]]
	{
		'SmiteshP/nvim-navic',
		dependencies = p.lspconfig,
	},
	---[[
	{
		'nvim-treesitter/playground',
		dependencies = p.treesitter,
	},
	--]]
	{
		'euclio/vim-markdown-composer',
		build = 'cargo build --release',
		config = function()
			Events.plugin_setup:sub(Plugins.vim_markdown_composer)
		end
	},
	{
		'rest-nvim/rest.nvim',
		dependencies = p.plenary,
		config = function()
			Events.plugin_setup:sub(Plugins.rest)
		end
	},
	-- STATUSBAR:
	{
		'rebelot/heirline.nvim',
		dependencies = p.devicons,
	},
	-- Active's Stuff:
	{ 'vim-scripts/a.vim', },
	{ 'maxbane/vim-asm_ca65', },
	{
		'hedyhli/outline.nvim',
		lazy = true,
		cmd = { 'Outline', 'OutlineOpen' },
		opts = ActivesStuff.outline
	},
	{
		'SmiteshP/nvim-navbuddy',
		dependencies = {
			'SmiteshP/nvim-navic',
			'MunifTanjim/nui.nvim',
		},
		config = function()
			Events.plugin_setup:sub(ActivesStuff.navbuddy)
		end
	},
	--  { 'kana/vim-smartword', },
	{
		'folke/todo-comments.nvim',
		dependencies = p.plenary,
		config = function()
			Events.plugin_setup:sub(ActivesStuff.todo_comments)
		end
	},
	{
		'windwp/nvim-autopairs',
		config = function()
			Events.plugin_setup:sub(ActivesStuff.autopairs)
		end
	},

	-- PLUGINS:
	{
		'echasnovski/mini.nvim',
		config = function()
			Events.plugin_setup:sub(Plugins.mini_starter)
			Events.plugin_setup:sub(Plugins.mini_surround)
			Events.plugin_setup:sub(Plugins.mini_map)
			Events.plugin_setup:sub(Plugins.mini_bufremove)
			Events.plugin_setup:sub(Plugins.mini_move)
		end
	},
	{
		'RRethy/vim-illuminate',
		config = function()
			Events.plugin_setup:sub(Plugins.illuminate)
		end
	},
	{
		p.gitsigns,
		dependencies = p.plenary,
		config = function()
			Events.plugin_setup:sub(Plugins.gitsigns)
		end
	},
	{
		'nvim-neo-tree/neo-tree.nvim',
		-- branch = "v2.x",
		dependencies = {
			p.plenary,
			p.nui,
			p.devicons,
			's1n7ax/nvim-window-picker',
		},
		config = function()
			Events.plugin_setup:sub(Plugins.neo_tree)
		end
	},
	{
		'akinsho/nvim-toggleterm.lua',
		config = function()
			Events.plugin_setup:sub(ActivesStuff.toggle_term)
		end
	},
	{
		'nvim-telescope/telescope-ui-select.nvim',
		config = function()
			Events.plugin_setup:sub(Plugins.telescope_ui_select)
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		-- branch = '0.1.x',
		dependencies = {
			p.plenary,
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = FZF_BUILD_CMD,
			},
		},
		config = function()
			Events.plugin_setup:sub(Plugins.telescope)
		end
	},
	{
		'jghauser/fold-cycle.nvim',
		config = function()
			Events.plugin_setup:sub(Plugins.fold_cycle)
		end
	},
	{
		'anuvyklack/fold-preview.nvim',
		dependencies = 'anuvyklack/keymap-amend.nvim',
		config = function()
			Events.plugin_setup:sub(Plugins.fold_preview)
		end
	},
	{
		'NvChad/nvim-colorizer.lua',
		config = function()
			Events.plugin_setup:sub(Plugins.colorizer)
		end
	},
	{
		'folke/noice.nvim',
		dependencies = p.nui,
		config = function()
			Events.plugin_setup:sub(Plugins.noice)
		end
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'lukas-reineke/cmp-rg',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-buffer',
		},
		config = function()
			Events.plugin_setup:sub(ActivesStuff.cmp_ls)
		end
	},
	{
		'stevearc/dressing.nvim',
		config = function()
			Events.plugin_setup:sub(Plugins.dressing)
		end
	},
	{
		'RaafatTurki/hex.nvim',
		dev = false,
		config = function()
			Events.plugin_setup:sub(Plugins.hex)
		end
	},
	-- p.dap,
	-- {'rcarriga/nvim-dap-ui',                            dependencies = p.dap },
	-- UNCHARTED:
	{
		'folke/paint.nvim',
		config = function()
			Events.plugin_setup:sub(Plugins.paint)
		end,
	},
	{ 'tpope/vim-abolish',
		--config
	},
}

Events.install_pre:sub(function()
	Buffers.setup()
	Bind.setup()

	Misc.base()
	Misc.open_uri()
	-- Misc.color_col()
	Misc.term_smart_esc()
	Misc.disable_builtin_plugins()
	Misc.highlight_yank()
	-- Misc.diag_on_hold()
	Misc.pets()
	Misc.buffer_edits()
	Misc.auto_create_dir()
end)

Events.install_post:sub(function()
	Sessions.setup()

	Misc.auto_install_ts_parser()
	Misc.lorem_picsum()
	Misc.auto_gitignore_io()
	Misc.conceal_html_classes()

	Plugins.setup()

	Lang.setup()

	Lsp.setup()
	Lsp.setup_servers()

	Statusbar.setup()

	Bind.setup_plugins()

	ActivesStuff.setup()
end)

PluginManager.setup(plugins)
