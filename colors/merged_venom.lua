------------------------------ My Stuff - Mostly Lua Colors ------------------------------
local actives_theme = {
  --Untested
  ['@definition.function']          = { fg = "#FF00FF" },
  ['@definition.method']            = { fg = "#FF00FF" },
  ['@name']                         = { fg = "#FF00FF" },
  ['@reference.call']               = { fg = "#FF00FF" },
  ['@local.scope']                  = { fg = "#FF00FF" },
  ['@local.definition']             = { fg = "#FF00FF" },
  ['@local.reference']              = { fg = "#FF00FF" },
  ['@attribute']                    = { fg = "#FF00FF" },
  ['@method']                       = { fg = "#FF00FF" },
  ['@function.call']                = { fg = "#FF00FF" },
  ['@method.call']                  = { fg = "#FF00FF" },
  ['@preproc']                      = { fg = "#FF00FF" },
  ['@_cdef_identifier']             = { fg = "#FF00FF" },
  ['@injection.content']            = { fg = "#FF00FF" },
  ['@fieldconstructor']             = { fg = "#FF00FF" },


  --More generic ones, mostly (fully? not Lua related/relevant.
  ['@type']             = { fg = "#b44800", bold = true },
  ['@storageclass']             = { fg = "#422712" },
  ['@structure']             = { fg = "#d090e5" },
  ['@typedef']             = { fg = "#0030b4" },

  --factory-lang specific.
--  ['@factoryTag']             = { fg = "#5e7fdb" },
  ['factoryExternal']             = { '@repeat' },
  ['factoryInput']             = { fg = "#518049" },
  ['factoryProduct']             = { fg = "#ff0071", bold = true},
  ['factoryDeps']             = { fg = "#8ea3db"},

  --Generic, found through testing.
  ['@error']                        = { fg = "#a52020", undercurl = false },
  
  --Tested and works
  ['@constant']                     = { fg = "#FF2C60", bold = true },
  ['@variable']                     = { fg = "#FF3063" },
  ['@parameter']                    = { fg = "#FF3063" },
  ['@field']                        = { fg = "#22ffff" },

  
  ['@function']                     = { fg = "#5AAE76" },
  ['@function.call']                = { fg = "#196B34" },
  ['@keyword.function']             = { fg = "#3AFF7D" ,bold = true },

  ['@method']                       = { fg = "#5F89D9" },                      --5A76AE
  ['@method.call']                  = { fg = "#2845FF" },
  ['@variable.builtin']             = { fg = "#FFB389", italic = true},        --36576D

  ['@function.builtin']             = { fg = "#FF0000" },
  ['@constant.builtin']             = { fg = "#FF0000", bold = true },
  ['@namespace.builtin']            = { fg = "#FF0000" },

  ['@string']                       = { fg = "#AA00AA" },
  -- ['@number']                       = { fg = "#FF6600", },
  ['@number']                       = { fg = "#ff8636", },

  ['@comment']                      = { fg = "#005000" },
  ['@comment.documentation']        = { fg = "#FF6600" },
  
  ['@label']                        = { fg = "#A15F97", bold = true },
  ['@repeat']                       = { fg = "#FF6600" },
  ['@conditional']                  = { fg = "#00FF00" },

  ['@boolean']                      = { fg = "#FFFF22", bold = true},
  ['@keyword']                      = { fg = "#FFFF22" },
  ['@keyword.return']               = { fg = "#4444FF" },
  
  ['@keyowrd.operator']             = { fg = "#FFFFFF" },
  ['@operator']                     = { fg = "#FFFFFF" },
  ['@punctuation.delimiter']        = { fg = "#FFFFFF" },
  ['@punctuation.bracket']          = { fg = "#FFFFFF" },


 
--  ['@spell']                        = { fg = "#FF0000" },

  --Listed but seems to not work.
  ['@string.escape']                = { fg = "#FFFFFF" }, 

  --Other
  LineNr                       = { fg = "#006C7D" },    
  CursorLineNr                 = { fg = "#009CB5", bold = true },    
  NeoTreeCursorLine            = { fg = "#22FFFF" },
--[[
  ColorColumn                       = { fg = "#FFFF22" },    
  Cursor                            = { fg = "#FF0000" },    
  CursorIM                          = { fg = "#00FF00" },    
  CursorLine                        = { fg = "#0000FF" },    
  Normal                            = { fg = "#FF00FF" },    
--]]

--  ActiveWindow 				  = {bg = "#000d1f" },
--  InactiveWindow 			  = {bg = "#000B1A" },

  ActiveWindow 			  = {bg = "#000B1A" },
  InactiveWindow 		  = {bg = "#000814" },

}

------------------------------ Potato's Stuff ------------------------------
-- utils
local clamp = function(n, min, max)
  return math.min(math.max(n, min), max)
end

local mod = function(hex, amt)
  hex = hex:sub(2)
  local hex_r = hex:sub(1, 2)
  local hex_g = hex:sub(3, 4)
  local hex_b = hex:sub(5, 6)

  local r = tonumber(hex_r, 16)
  local g = tonumber(hex_g, 16)
  local b = tonumber(hex_b, 16)

  r = r + amt
  g = g + amt
  b = b + amt

  r = clamp(r, 0, 255)
  g = clamp(g, 0, 255)
  b = clamp(b, 0, 255)

  local rgb = (r * 0x10000) + (g * 0x100) + b
  return string.format("#%06x", rgb)
end

local mix = function(color1, color2)
  color1 = string.sub(color1, 2)
  color2 = string.sub(color2, 2)
  -- convert hex colors to decimal values
  local r1, g1, b1 = tonumber("0x"..string.sub(color1, 1, 2)), tonumber("0x"..string.sub(color1, 3, 4)), tonumber("0x"..string.sub(color1, 5, 6))
  local r2, g2, b2 = tonumber("0x"..string.sub(color2, 1, 2)), tonumber("0x"..string.sub(color2, 3, 4)), tonumber("0x"..string.sub(color2, 5, 6))
  -- average the values to get the mixed color
  local r, g, b = (r1 + r2) / 2, (g1 + g2) / 2, (b1 + b2) / 2
  -- convert decimal values back to hex
  return string.format("#%02x%02x%02x", r, g, b)
end

local gen_shades = function(col)
  local shades = {}
  for i = 0, 9 do
    local new_col = mod(col, i*3)
    table.insert(shades, new_col)
  end
  return shades
end


local set_hl = function(group_name, opts)
  local hl_opts = {
    fg = opts.fg,
    bg = opts.bg,
    sp = opts.sp,

    bold = opts.bold or false,
    standout = opts.standout or false,
    underline = opts.underline or false,
    undercurl = opts.undercurl or false,
    underdouble = opts.underdouble or false,
    underdotted = opts.underdotted or false,
    underdashed = opts.underdashed or false,
    strikethrough = opts.strikethrough or false,
    italic = opts.italic or false,
    reverse = opts.reverse or false,
    nocombine = opts.nocombine or false,
  }

  if opts.blend ~= nil then hl_opts.blend = clamp(opts.blend, 0, 100) end

  if opts[1] ~= nil then hl_opts.link = opts[1] end

  -- • blend: integer between 0 and 100
  -- • link: name of another highlight group to link
  -- to, see |:hi-link|.
  -- • default: Don't override existing definition
  -- |:hi-default|
  -- • ctermfg: Sets foreground of cterm color
  -- |highlight-ctermfg|
  -- • ctermbg: Sets background of cterm color
  -- |highlight-ctermbg|
  -- • cterm: cterm attribute map, like
  -- |highlight-args|. If not set, cterm attributes
  -- will match those from the attribute map
  -- documented above.

  vim.api.nvim_set_hl(0, group_name, hl_opts)
end

local set_hls = function(hl_table)
  for hl_group, opts in pairs(hl_table) do
    set_hl(hl_group, opts)
  end
end

local green     = gen_shades '#1F5E3F'
local white     = gen_shades '#C0B9DD'
local red       = gen_shades '#CB4251'
local orange    = gen_shades '#F37A2E'
local yellow    = gen_shades '#FFBE34'
local lime      = gen_shades '#AAD94C'
local cyan      = gen_shades '#409FFF'
local blue      = gen_shades '#3C4879'
local purple    = gen_shades '#4C3889'
local grey      = gen_shades '#222A3D'
local black     = gen_shades '#07080f'
local debug     = gen_shades '#FF00FF'

local c = {
  -- ui
  bg        = "#000814",                --"#010A14",              --#191F24",
  bg_float  = "#005F63",               --"#20505E",
  line      = "#041826",
  mg        = "#22FFFF",    
  fg        = "#CCCCCC",            --white[3],
  match     = grey[10],
  fold      = grey[8],

  -- general
  err       = "#FF0000",          --red[4],
  info      = "#22FFFF",          --cyan[4],
  warn      = "#D25C1C",          --yellow[4],
  hint      = "#492263",          --purple[4],

  add       = green[2],
  mod       = blue[1],
  del       = red[1],
  mod_alt   = cyan[1],

  -- vsc
  dirty     = orange[4],
  staged    = yellow[4],
  merge     = purple[1],
  renamed   = orange[1],
  deleted   = red[1],

  -- syntax
  comment   = grey[2],
  link      = cyan[3],
  note      = blue[10],
  value     = red[10],
  variable  = purple[10],
  constant  = red[1],
  func      = yellow[1],
  keyword   = orange[1],
  operator  = orange[10],
  string    = green[10],
  type      = cyan[1],
  include   = lime[10],

  -- special   = yellow[5],
  -- tag       = grey[8],

  -- others
  debug     = debug[1]
}

local potatos_theme = {
  -- TREESITTER:
  -- for more visit https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
  -- Misc
  ['@comment']           = { fg = c.comment },
  ['@error']             = { fg = c.err },
  ['@none']              = { fg = c.include },
  ['@preproc']           = { fg = c.include },
  ['@define']            = { '@preproc' },
  ['@operator']          = { fg = c.operator },
  -- Punctuation
  ['@punctuation.bracket']    = { '@operator' },
  ['@punctuation.delimiter']  = { '@operator' },
  ['@punctuation.special']    = { '@operator' },
  -- Literals
  ['@string']             = { fg = c.string },
  ['@string.regex']       = { '@string' },
  ['@string.escape']      = { '@string' },
  ['@string.special']     = { '@string' },
  ['character']           = { '@string' },
  ['character.special']   = { '@string' },
  ['@number']             = { fg = c.value },
  ['@boolean']            = { '@number' },
  ['@float']              = { '@number' },
  -- Functions
  ['@function']           = { fg = c.func },
  ['@function.builtin']   = { '@function' },
  ['@function.call']      = { '@function' },
  ['@function.macro']     = { '@function' },
  ['@method']             = { '@function' },
  ['@method.call']        = { '@function' },
  ['@constructor']        = { '@function' },
  ['@parameter']          = { '@variable' },
  -- Keywords
  ['@keyword']            = { fg = c.keyword },
  ['@keyword.function']   = { '@keyword' },
  ['@keyword.operator']   = { '@keyword' },
  ['@keyword.return']     = { '@keyword' },
  ['@conditional']        = { '@keyword' },
  ['@repeat']             = { '@keyword' },
  ['@debug']              = { fg = c.debug },
  ['@label']              = { '@keyword' },
  ['@include']            = { fg = c.include },
  ['@exception']          = { '@keyword' },
  -- Types
  ['@type']               = { fg = c.type },
  ['@type.builtin']       = { '@type' },
  ['@type.definition']    = { '@type' },
  ['@type.qualifier']     = { '@type' },
  ['@storageclass']       = { '@type' },
  ['@attribute']          = { '@variable' },
  ['@field']              = { '@variable' },
  ['@property']           = { '@variable' },
  -- Identifiers
  ['@variable']           = { fg = c.fg }, -- c.variable,
  ['@variable.builtin']   = { '@variable' },
  ['@constant']           = { fg = c.constant },
  ['@constant.builtin']   = { '@constant' },
  ['@constant.macro']     = { '@constant' },
  ['@namespace']          = { '@type' },
  ['@symbol']             = { '@variable' },
  -- Text
  ['@text']                   = { fg = c.fg },
  ['@text.strong']            = { bold = true },
  ['@text.emphasis']          = { italic = true },
  ['@text.underline']         = { underline = true },
  ['@text.strike']            = { strikethrough = true },
  ['@text.title']             = { fg = c.fg, bold = true },
  ['@text.literal']           = { '@string' },
  ['@text.uri']               = { underline = true, fg = c.link },
  ['@text.math']              = { '@keyword' },
  ['@text.environment']       = { '@function' },
  ['@text.environment.name']  = { '@constant' },
  ['@text.reference']         = { '@text.uri' },
  ['@text.todo']              = { },
  ['@text.note']              = { },
  ['@text.warning']           = { },
  ['@text.danger']            = { },
  ['@text.diff.add']          = { fg = c.add },
  ['@text.diff.delete']       = { fg = c.del },
  -- Tags
  ['@tag']                = { '@keyword' },
  ['@tag.attribute']      = { '@variable' },
  ['@tag.delimiter']      = { '@variable' },

  -- Conceal
  -- ['@conceal']         = {},

  -- Spell
  -- ['@spell']           = {},

  -- Non-standard (optional)
  -- ['@variable.global'] = {}

  -- Locals
  -- ['@definition']
  -- ['@definition.constant']
  -- ['@definition.function']
  -- ['@definition.method']
  -- ['@definition.var']
  -- ['@definition.parameter']
  -- ['@definition.macro']
  -- ['@definition.type']
  -- ['@definition.field']
  -- ['@definition.enum']
  -- ['@definition.namespace']
  -- ['@definition.import']
  -- ['@definition.associated']
  --
  -- ['@scope']
  -- ['@reference']


  -- LSP SEMANTIC HIGHLIGHT
  ['@lsp.type.namespace']   = { '@namespace' },
  ['@lsp.type.type']        = { '@type' },
  ['@lsp.type.class']       = { '@type' },
  ['@lsp.type.enum']        = { '@type' },
  ['@lsp.type.interface']   = { '@type' },
  ['@lsp.type.struct']      = { '@structure' },
  ['@lsp.type.parameter']   = { '@parameter' },
  ['@lsp.type.variable']    = { '@variable' },
  ['@lsp.type.property']    = { '@property' },
  ['@lsp.type.enumMember']  = { '@constant' },
  ['@lsp.type.function']    = { '@function' },
  ['@lsp.type.method']      = { '@method' },
  ['@lsp.type.macro']       = { '@macro' },
  ['@lsp.type.decorator']   = { '@function' },


  -- N/VIM
  ColorColumn	    = { 'CursorLine' },
  Conceal         = { 'Folded' },
  CurSearch       = { bg = c.match, bold = true },
  Cursor          = { bg = c.fg },
  CursorColumn    = { 'CursorLine' }, --
  CursorIM        = { }, --
  CursorLine      = { bg = c.line },
  CursorLineFold  = { 'CursorLine' },
  CursorLineNr    = { 'CursorLine' },
  CursorLineSign  = { 'CursorLine' },
  DiffAdd         = { fg = c.add },
  DiffChange      = { fg = c.mod },
  DiffDelete      = { fg = c.del },
  DiffText        = { fg = c.mod_alt },
  Directory       = { }, --
  EndOfBuffer     = { }, --
  ErrorMsg        = { fg = c.err },
  FoldColumn      = { }, --
  Folded          = { fg = c.fold, bold = true },
  lCursor         = { }, --
  IncSearch       = { 'Search' },
  LineNr          = { fg = c.comment, italic = true },
  LineNrAbove     = { }, --
  LineNrBelow     = { }, --
  MatchParen      = { bold = true },
  ModeMsg         = { fg = c.fg, bold = true },
  MoreMsg         = { fg = c.info },
  MsgArea         = { fg = c.match },
  MsgSeparator    = { bg = c.bg_float, fg = c.mg },
  NonText         = { fg = c.comment, bold = true },
  Normal          = { bg = c.bg },
  NormalFloat     = { bg = c.bg },
  FloatBorder     = { fg = c.mg },
  NormalNC        = { }, --
  Pmenu           = { bg = c.line, fg = c.fg },
  PmenuSel        = { bg = c.mg, fg = c.fg },
  PmenuSbar       = { 'Pmenu' },
  PmenuThumb      = { bg = c.mg },
  Question        = { fg = c.fg, bold = true },
  QuickFixLine    = { 'PmenuSel' },
  Search          = { bg = c.mg, bold = true },
  SignColumn      = { }, --
  SpecialKey      = { fg = c.fold },
  SpellBad        = { undercurl = true, sp = c.err },
  SpellCap        = { }, --
  SpellLocal      = { }, --
  SpellRare       = { }, --
-- StatusLine      = { bg = c.debug }, --
  StatusLine      = { 'NormalFloat' }, --
  StatusLineNC    = { reverse = true },
  Substitute      = { 'CurSearch' },
  TabLineFill     = { bg = c.bg_float },
  TabLine         = { bg = c.bg_float, fg = c.fold },
  TabLineSel      = { bg = c.bg_float, fg = c.fg, bold = true },
  TermCursor      = { underline = true },
  TermCursorNC    = { 'TermCursor' },
  Title           = { '@text.title' },
  Visual          = { bg = c.fold, bold = true },
  VisualNOS       = { }, --
  WarningMsg      = { fg = c.warn },
Whitespace      = { 'Debug' },
  WildMenu        = { 'Pmenu' },
  WinBar          = { 'NormalFloat' },
  WinBarNC        = { }, --
  WinSeparator    = { fg = c.mg },

  -- DEPRECATED
  VertSplit       = { 'WinSeparator' },
  FloatTitle      = { '@text.title' };


  -- LSP
  LspReferenceText            = { underline = true };
  LspReferenceRead            = { underline = true };
  LspReferenceWrite           = { underline = true };
  LspCodeLens                 = { 'Comment' },
LspCodeLensSeparator        = { '@debug' },
  LspSignatureActiveParameter = { underline = true, bold = true },


  -- Diagnostics
  DiagnosticError             = { fg = c.err },
  DiagnosticWarn              = { fg = c.warn },
  DiagnosticInfo              = { fg = c.info },
  DiagnosticHint              = { fg = c.hint },
  DiagnosticVirtualTextError  = { 'DiagnosticError' },
  DiagnosticVirtualTextWarn   = { 'DiagnosticWarn' },
  DiagnosticVirtualTextInfo   = { 'DiagnosticInfo' },
  DiagnosticVirtualTextHint   = { 'DiagnosticHint' },
  DiagnosticUnderlineError    = { undercurl = false, sp = c.err },
  DiagnosticUnderlineWarn     = { undercurl = false, sp = c.warn },
  DiagnosticUnderlineInfo     = { undercurl = false, sp = c.info },
  DiagnosticUnderlineHint     = { undercurl = false, sp = c.hint },
  DiagnosticFloatingError     = { 'DiagnosticError' },
  DiagnosticFloatingWarn      = { 'DiagnosticWarn' },
  DiagnosticFloatingInfo      = { 'DiagnosticInfo' },
  DiagnosticFloatingHint      = { 'DiagnosticHint' },
  DiagnosticSignError         = { 'DiagnosticError' },
  DiagnosticSignWarn          = { 'DiagnosticWarn' },
  DiagnosticSignInfo          = { 'DiagnosticInfo' },
  DiagnosticSignHint          = { 'DiagnosticHint' },


  -- Vim
  -- those are no longer used for syntax highlighting, they server as fallbacks for plugins
  Comment                 = { '@comment' },
  Constant                = { '@constant' },
  String                  = { '@string' },
  Character               = { '@character' },
  Number                  = { '@number' },
  Boolean                 = { '@boolean' },
  Float                   = { '@float' },
  Identifier              = { '@variable' },
  Function                = { '@function' },
  Statement               = { '@keyword' },
  Keyword                 = { '@keyword' },
  Conditional             = { '@conditional' },
  Repeat                  = { '@repeat' },
  Label                   = { '@label' },
  Operator                = { '@operator' },
  Exception               = { '@exception' },
  Include                 = { '@include' },
  PreProc                 = { '@preProc' },
  Macro                   = { '@preProc' },
  PreCondit               = { '@preProc' },
  Define                  = { '@define' },
  Type                    = { '@type' },
  StorageClass            = { '@storageclass' },
  Structure               = { '@type.builtin' },
  Typedef                 = { '@type.definition' },
  Special                 = { '@string.special' },
  SpecialChar             = { '@character.special' },
  Tag                     = { '@tag' },
  Delimiter               = { '@punctuation.delimiter' },
  SpecialComment          = { '@text.note' },
  Debug                   = { '@debug' },
  Underlined              = { '@underline' },
  Error                   = { '@error' },
  Ignore                  = { fg = c.bg_float };
  Todo                    = { '@text.todo' },


  -- TS Filetype Specific
  healthSuccess           = { fg = c.add, bold = true };
  healthWarning           = { fg = c.warn, bold = true };
  healthError             = { fg = c.err, bold = true };
  healthHelp              = { '@text.reference' };
healthBar               = { '@debug' };


  -- Plugins
  LspInfoTitle            = { 'Label' };
  LspInfoList             = { 'Label' };
  LspInfoFiletype         = { 'Type' };
  LspInfoTip              = { 'Comment' };
  LspInfoBorder           = { 'FloatBorder' };

  -- diff
  diffAdded               = { fg = c.add };
  diffChanged             = { fg = c.mod };
  diffRemoved             = { fg = c.del };
  diffOldFile             = { bg = c.del };
  diffNewFile             = { bg = c.add };
  diffFile                = { fg = c.comment };
  diffLine                = { fg = c.fg };
  diffIndexLine           = { fg = c.comment };

  -- gitsigns
  GitSignsAdd             = { fg = c.add };
  GitSignsAddNr           = { fg = c.add };
  GitSignsAddLn           = { fg = c.add };
  GitSignsChange          = { fg = c.mod };
  GitSignsChangeNr        = { fg = c.mod };
  GitSignsChangeLn        = { fg = c.mod };
  GitSignsDelete          = { fg = c.del };
  GitSignsDeleteNr        = { fg = c.del };
  GitSignsDeleteLn        = { fg = c.del };

  -- cmp
  CmpItemAbbr             = { fg = c.fold };
  CmpItemAbbrDeprecated   = { fg = c.fold, strikethrough = true };
  CmpItemAbbrMatch        = { fg = c.fg, bold = true };
  CmpItemAbbrMatchFuzzy   = { fg = c.fg };
  CmpItemKind             = { };
  CmpItemMenu             = { fg = c.comment  };
  CmpItemKindText         = { fg = c.fg       };
  CmpItemKindMethod       = { fg = c.func     };
  CmpItemKindFunction     = { fg = c.func     };
  CmpItemKindConstructor  = { fg = c.special  };
  CmpItemKindField        = { fg = c.entity   };
  CmpItemKindVariable     = { fg = c.keyword  };
  CmpItemKindClass        = { fg = c.type     };
  CmpItemKindInterface    = { fg = c.type     };
  CmpItemKindModule       = { fg = c.special  };
  CmpItemKindProperty     = { fg = c.entity   };
  CmpItemKindUnit         = { fg = c.keyword  };
  CmpItemKindValue        = { fg = c.string   };
  CmpItemKindEnum         = { fg = c.keyword  };
  CmpItemKindKeyword      = { fg = c.keyword  };
  CmpItemKindSnippet      = { fg = c.constant };
  CmpItemKindColor        = { fg = c.string   };
  CmpItemKindFile         = { fg = c.fg       };
  CmpItemKindReference    = { fg = c.entity   };
  CmpItemKindFolder       = { fg = c.fg       };
  CmpItemKindEnumMember   = { fg = c.string   };
  CmpItemKindConstant     = { fg = c.constant };
  CmpItemKindStruct       = { fg = c.string   };
  CmpItemKindEvent        = { fg = c.special  };
  CmpItemKindOperator     = { fg = c.operator };
  CmpItemKindTypeParameter= { fg = c.type     };

  -- scrollview
  ScrollView              = { bg = c.mg };

  -- scrollbar
  ScrollbarHandle         = { 'ScrollView' };
  ScrollbarSearchHandle   = { bg = c.mg, fg = c.fg };
  ScrollbarSearch         = { fg = c.fg };
  ScrollbarErrorHandle    = { bg = c.mg, fg = c.err };
  ScrollbarError          = { fg = c.err };
  ScrollbarWarnHandle     = { bg = c.mg, fg = c.warn };
  ScrollbarWarn           = { fg = c.warn };
  ScrollbarInfoHandle     = { bg = c.mg, fg = c.info };
  ScrollbarInfo           = { fg = c.info };
  ScrollbarHintHandle     = { bg = c.mg, fg = c.hint };
  ScrollbarHint           = { fg = c.hint };
  ScrollbarMiscHandle     = { bg = c.mg, fg = c.fg };
  ScrollbarMisc           = { fg = c.fg };

  -- nvim-tree
  -- NvimTreeNormal          = { bg = c.bg_alt };
  NvimTreeRootFolder      = { fg = c.fg };
  NvimTreeFolderIcon      = { fg = c.fg };
  NvimTreeFileIcon        = { fg = c.fg };
  NvimTreeSpecialFile     = { fg = c.fg };
  NvimTreeExecFile        = { bold = true };
  NvimTreeSymlink         = { underline = true };
  NvimTreeIndentMarker    = { fg = c.mg };
  NvimTreeImageFile       = { fg = c.fg };
  NvimTreeOpenedFile      = { fg = c.fg };
  NvimTreeGitDirty        = { fg = c.dirty };
  NvimTreeGitStaged       = { fg = c.staged };
  NvimTreeGitMerge        = { fg = c.merge };
  NvimTreeGitRenamed      = { fg = c.renamed };
  NvimTreeGitDeleted      = { fg = c.deleted };
  NvimTreeLspDiagnosticsError       = { 'DiagnosticSignError' };
  NvimTreeLspDiagnosticsWarning     = { 'DiagnosticSignWarn' };
  NvimTreeLspDiagnosticsInformation = { 'DiagnosticSignInfo' };
  NvimTreeLspDiagnosticsHint        = { 'DiagnosticSignHint' };

  -- neo-tree
  NeoTreeBufferNumber         = { 'Comment' };
  NeoTreeCursorLine           = { 'CursorLine' };
  NeoTreeDirectoryIcon        = {}; --
  NeoTreeDirectoryName        = {}; --
  NeoTreeDimText              = { 'Folded' };
  NeoTreeDotfile              = { 'Comment' };
  NeoTreeFileIcon             = { 'NvimTreeFileIcon' };
  NeoTreeModified             = { 'ReachModifiedIndicator' };
  NeoTreeFileName             = {}; --
  NeoTreeFileNameOpened       = { bold = true };
  NeoTreeFilterTerm           = {};
  NeoTreeFloatBorder          = { 'FloatBorder' };
  NeoTreeFloatTitle           = { 'Title' };
  NeoTreeGitAdded             = { 'NvimTreeGit' };
  NeoTreeGitConflict          = { 'NvimTreeGitMerge' };
  NeoTreeGitDeleted           = { 'NvimTreeGitDeleted' };
  NeoTreeGitIgnored           = { fg = c.mg };
  NeoTreeGitModified          = { 'NeoTreeModified' };
  NeoTreeGitUnstaged          = { fg = c.dirty };
  NeoTreeGitUntracked         = { fg = c.dirty };
  NeoTreeGitStaged            = { 'NvimTreeGitStaged' };
  NeoTreeHiddenByName         = { 'Comment' };
  NeoTreeIndentMarker         = { 'NvimTreeIndentMarker' };
  NeoTreeExpander             = { 'NvimTreeIndentMarker' };
  NeoTreeNormal               = {}; --
  NeoTreeNormalNC             = {}; --
  NeoTreeSignColumn           = {}; --
  NeoTreeStatusLine           = {}; --
  NeoTreeStatusLineNC         = {}; --
  NeoTreeVertSplit            = {}; --
  NeoTreeWinSeparator         = {}; --
  NeoTreeEndOfBuffer          = { '@debug' };
  NeoTreeRootName             = { 'Title' };
  NeoTreeSymbolicLinkTarget   = { '@debug' };
  NeoTreeTitleBar             = { '@debug' };
  NeoTreeWindowsHidden        = { '@debug' };
  NeoTreeTabActive            = { 'Normal' };
  NeoTreeTabInactive          = { 'Comment' };
  NeoTreeTabSeparatorActive   = { 'Ignore' };
  NeoTreeTabSeparatorInactive = { 'Ignore' };

  -- vim-quickui
  QuickBG                 = { bg = c.bg_float, fg = c.fg };
  QuickSel                = { 'Search' };
  QuickKey                = { fg = c.err };
  QuickOff                = { fg = c.mg };
  QuickHelp               = { 'WarningMsg' };

  -- outline
  FocusedSymbol           = { 'Search' };
  SymbolsOutlineConnector = { fg = c.mg };

  -- telescope
  TelescopeMatching       = { fg = c.fg, bold = true };
  TelescopeMultiSelection = { fg = c.type };
  TelescopeSelectionCaret = { 'NormalFloat' };
  TelescopeNormal         = { fg = c.mg };
  TelescopePreviewNormal  = { 'NormalFloat' };
  TelescopePromptNormal   = { 'NormalFloat' };
  TelescopeSelection      = { 'CursorLine' };
  TelescopeTitle          = { 'Title' };
  TelescopePreviewTitle   = { 'Title' };
  TelescopePromptTitle    = { 'Title' };
  TelescopeBorder         = { 'FloatBorder' };
  TelescopePromptBorder   = { 'FloatBorder' };

  -- harpoon
  HarpoonBorder           = { 'FloatBorder' };

  -- startup-time
  StartupTimeStartupKey   = { bold = true };
  StartupTimeStartupValue = { bold = true };
  StartupTimeHeader       = { 'Comment' };
  StartupTimeSourcingEvent= { fg = cyan[5] };
  StartupTimeOtherEvent   = { fg = purple[5] };
  StartupTimeTime         = { fg = red[5] };
  StartupTimePercent      = { fg = red[5] };
  StartupTimePlot         = { fg = red[1] };

  -- notify
  NotifyERRORBorder       = { 'DiagnosticVirtualTextError' };
  NotifyWARNBorder        = { 'DiagnosticVirtualTextWarn' };
  NotifyINFOBorder        = { 'DiagnosticVirtualTextInfo' };
  NotifyTRACEBorder       = { 'DiagnosticFloatingHint' };
  NotifyDEBUGBorder       = { 'DiagnosticVirtualTextHint' };
  NotifyERRORIcon         = { fg = c.fg };
  NotifyWARNIcon          = { fg = c.fg };
  NotifyINFOIcon          = { fg = c.fg };
  NotifyDEBUGIcon         = { fg = c.fg };
  NotifyTRACEIcon         = { fg = c.fg };
  NotifyERRORTitle        = { 'NotifyERRORBorder', bold = true};
  NotifyWARNTitle         = { 'NotifyWARNBorder',  bold = true};
  NotifyINFOTitle         = { 'NotifyINFOBorder',  bold = true};
  NotifyDEBUGTitle        = { 'NotifyDEBUGBorder', bold = true};
  NotifyTRACETitle        = { 'NotifyTRACEBorder', bold = true};
  NotifyERRORBody         = { 'Normal' };
  NotifyWARNBody          = { 'Normal' };
  NotifyINFOBody          = { 'Normal' };
  NotifyDEBUGBody         = { 'Normal' };
  NotifyTRACEBody         = { 'Normal' };

  -- ultest
  UltestPass              = { fg = c.add };
  UltestFail              = { fg = c.err };
  UltestRunning           = { fg = c.warn };
  UltestBorder            = { 'FloatBorder' };
  UltestSummaryInfo       = { fg = c.fold };
  UltestSummaryFile       = { 'UltestSummaryInfo', bold = true};
  UltestSummaryNamespace  = { 'UltestSummaryFile' };

  -- reach
  ReachBorder             = { 'FloatBorder' };
  ReachDirectory          = { 'Directory' };
  ReachModifiedIndicator  = { 'String' };
  ReachHandleBuffer       = { 'String' };
  ReachHandleDelete       = { 'Error' };
  ReachHandleSplit        = { 'Directory' };
  ReachTail               = { fg = c.fold };
  ReachHandleMarkLocal    = { 'Type' };
  ReachHandleMarkGlobal   = { 'Number' };
  ReachMark               = { 'Normal' };
  ReachMarkLocation       = { 'Comment' };
  ReachHandleTabpage      = { 'TabLineSel' };
  ReachGrayOut            = { 'Comment' };
  ReachMatchExact         = { 'String' };
  ReachPriority           = { 'WarningMsg' };
  ReachCurrent            = { fg = c.fg, bold = true};

  -- navic
  NavicIconsFile          = { 'CmpItemKindFile' };
  NavicIconsModule        = { 'CmpItemKindModule' };
  NavicIconsNamespace     = { 'CmpItemKindModule' };
  NavicIconsPackage       = { 'CmpItemKindModule' };
  NavicIconsClass         = { 'CmpItemKindClass' };
  NavicIconsMethod        = { 'CmpItemKindMethod' };
  NavicIconsProperty      = { 'CmpItemKindProperty' };
  NavicIconsField         = { 'CmpItemKindField' };
  NavicIconsConstructor   = { 'CmpItemKindConstructor' };
  NavicIconsEnum          = { 'CmpItemKindEnum' };
  NavicIconsInterface     = { 'CmpItemKindInterface' };
  NavicIconsFunction      = { 'CmpItemKindFunction' };
  NavicIconsVariable      = { 'CmpItemKindVariable' };
  NavicIconsConstant      = { 'CmpItemKindConstant' };
  NavicIconsString        = { 'CmpItemKindValue' };
  NavicIconsNumber        = { 'CmpItemKindValue' };
  NavicIconsBoolean       = { 'CmpItemKindValue' };
  NavicIconsArray         = { 'CmpItemKindValue' };
  NavicIconsObject        = { 'CmpItemKindValue' };
  NavicIconsKey           = { 'CmpItemKindProperty' };
  NavicIconsNull          = { 'CmpItemKindConstant' };
  NavicIconsEnumMember    = { 'CmpItemKindEnumMember' };
  NavicIconsStruct        = { 'CmpItemKindStruct' };
  NavicIconsEvent         = { 'CmpItemKindEvent' };
  NavicIconsOperator      = { 'CmpItemKindOperator' };
  NavicIconsTypeParameter = { 'CmpItemKindTypeParameter' };
  NavicText               = { 'CmpItemKindText' };
  NavicSeparator          = { 'Folded' };

  -- fidget
  FidgetTitle             = { 'Folded' },
  FidgetTask              = { 'Comment' },

  -- illuminate
  IlluminatedWordText     = { 'LspReferenceText' };
  IlluminatedWordRead     = { 'LspReferenceRead' };
  IlluminatedWordWrite    = { 'LspReferenceWrite' };

  -- modicator
  NormalMode              = { fg = c.fg };
  InsertMode              = { fg = c.del };
  VisualMode              = { fg = c.add };
  CommandMode             = { fg = c.warn };
  ReplaceMode             = { 'CommandMode' };
  SelectMode              = { fg = c.add };
  TerminalMode            = { fg = c.type };

  MiniStarterHeader       = { 'Label' };
  MiniStarterFooter       = { 'Label' };
  MiniStarterSection      = { 'Label' };
  -- MiniStarterCurrent      = { 'Title' };
  -- MiniStarterItem         = { 'Normal' };

  MiniMapNormal           = { 'Normal' };
  -- MiniMapSymbolCount      = { '' };
  MiniMapSymbolLine       = { 'Normal' };
  MiniMapSymbolView       = { 'Comment' };
  MiniAnimateCursor       = { bg = c.fg };

  MiniHipatternsFixme     = { bold = true, fg = c.err };
  MiniHipatternsHack      = { bold = true, fg = c.hint };
  MiniHipatternsTodo      = { bold = true, fg = c.warn };
  MiniHipatternsNote      = { bold = true, fg = c.note };

  -- CUTSOM GROUPS
  -- DebugFg                 = { fg = debug[10] };
  -- DebugBg                 = { bg = debug[1] };
  -- DebugAll                = { bg = debug[1], fg = debug[10] };
  -- NormalAlt               = { bg = c.bg_alt };
  SnippetPassiveIndicator = { 'Comment' };
  SnippetInsertIndicator  = { fg = c.fg };
  SnippetChoiceIndicator  = { fg = c.hint };
  -- CursorLineSelect        = { fg = c.fg, bg = c.line, bold = true },
  Camel                   = { fg = c.warn };
}

------------------------------ Highlight Active Window ------------------------------


------------------------------ Merge & Activate ------------------------------
for k, v in pairs(actives_theme) do
    potatos_theme[k] = v
end

set_hls(potatos_theme)
