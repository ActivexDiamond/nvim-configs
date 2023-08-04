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


local c = {}

local highlights = {
  -- TREESITTER:
  -- for more visit https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
  -- Misc
  ['@comment']           = { fg = "#FF00FF" },
  ['@error']             = { fg = "#FF0000" },
  ['@none']              = { fg = "#FFFFFF" },
  ['@preproc']           = { fg = "#FF00FF" },
  ['@define']            = { fg = "#FF00FF" },
  ['@operator']          = { fg = "#FFFFFF" },
  -- Punctuation
  ['@punctuation.bracket']    = { fg = "#FFFFFF" },
  ['@punctuation.delimiter']  = { fg = "#22FFFF", bold = true },
  ['@punctuation.special']    = { fg = "#66FF55" },
  -- Literals
  ['@string']             = { fg = "#AA00AA" },
  ['@string.regex']       = { fg = "#22FFFF" },
  ['@string.escape']      = { fg = "#BBFFFF" },
  ['@string.special']     = { fg = "#FFFFFF" },
  ['character']           = { fg = "#FF6600" },
  ['character.special']   = { fg = "#FFFFFF" },
  ['@number']             = { fg = "#880000" },
  ['@boolean']            = { fg = "#FFFF22", bold = true },
  ['@float']              = { fg = "#880000", italic = true} ,
  -- Functions
  ['@function']           = { fg = "#FFFF22", bold = true },
  ['@function.builtin']   = { fg = "#FF2200" },
  ['@function.call']      = { fg = "#00FF00" },
  ['@function.macro']     = { fg = "#FFFFFF" },
  ['@method']             = { fg = "#00AAAA" },
  ['@method.call']        = { fg = "#0000FF" },
  ['@constructor']        = { fg = "#4444FF" },
  ['@parameter']          = { fg = "#F11F1F" },
  -- Keywords
  ['@keyword']            = { fg = "#FFFF22"},
  ['@keyword.function']   = { fg = "#FFFF22", bold = true },
  ['@keyword.operator']   = { fg = "#AFFFF0" },
  ['@keyword.return']     = { fg = "#4444FF", italic = true },
  ['@conditional']        = { fg = "#00FF00" },
  ['@repeat']             = { fg = "#A0FFAA" },
  ['@debug']              = { fg = "#AAF00A" },
  ['@label']              = { fg = "#AAF0F0" },
  ['@include']            = { fg = "#000FF0" },
  ['@exception']          = { fg = "#5F0FF0" },
  -- Types
  ['@type']               = { fg = "#FF2200" },
  ['@type.builtin']       = { fg = "#AFFFF0" },
  ['@type.definition']    = { fg = "#4444FF" },
  ['@type.qualifier']     = { fg = "#00FF00" },
  ['@storageclass']       = { fg = "#00FF00", bold = true},
  ['@attribute']          = { fg = "#FF2200" },
  ['@field']              = { fg = "#FFffFF", bold=true},
  ['@property']           = { fg = "#FFffFF" },
  -- Identifiers
  ['@variable']           = { fg = "#FF2200" }, -- c.variable,
  ['@variable.builtin']   = { fg = "#afffff" },
  ['@constant']           = { fg = "#4444FF" },
  ['@constant.builtin']   = { fg = "#00ff00" },
  ['@constant.macro']     = { fg = "#00ff00" },
  ['@namespace']          = { fg = "#FFffFF", bold=true},
  ['@symbol']             = { fg = "#FFfffF", bold=true},
  -- Text
  ['@text']                   = { fg = "#FF2200" },
  ['@text.strong']            = { bold = true },
  ['@text.emphasis']          = { italic = true },
  ['@text.underline']         = { underline = true },
  ['@text.strike']            = { strikethrough = true },
  ['@text.title']             = { bold = true },
  ['@text.literal']           = { fg = "#FF00FF" },
  ['@text.uri']               = { underline = true, fg = "#FF00FF" },
  ['@text.math']              = { fg = "#00ff00" },
  ['@text.environment']       = { fg = "#afffff" },
  ['@text.environment.name']  = { fg = "#aaf00f" },
  ['@text.reference']         = { fg = "#00ff00" },
  ['@text.todo']              = { fg = "#FF00FF" },
  ['@text.note']              = { fg = "#FF00FF" },
  ['@text.warning']           = { fg = "#FF00FF" },
  ['@text.danger']            = { bg = c.err, fg = "#FF00FF" },
  ['@text.diff.add']          = { fg = "#FF00FF" },
  ['@text.diff.delete']       = { fg = "#FF00FF" },
  -- Tags
  ['@tag']                = { fg = "#FF2222" },
  ['@tag.attribute']      = { fg = "#FF2222" },
  ['@tag.delimiter']      = { fg = "#00ff00" },

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
  DiffAdd         = { fg = "#FF00FF" },
  DiffChange      = { fg = "#FF00FF" },
  DiffDelete      = { fg = "#FF00FF" },
  DiffText        = { fg = "#FF00FF" },
  Directory       = { }, --
  EndOfBuffer     = { }, --
  ErrorMsg        = { fg = "#FF00FF" },
  FoldColumn      = { }, --
  Folded          = { fg = "#FF00FF", bold = true },
  lCursor         = { }, --
  IncSearch       = { 'Search' },
  LineNr          = { fg = "#FF00FF", italic = true },
  LineNrAbove     = { }, --
  LineNrBelow     = { }, --
  MatchParen      = { bold = true },
  ModeMsg         = { fg = "#FF00FF", bold = true },
  MoreMsg         = { fg = "#FF00FF" },
  MsgArea         = { fg = "#FF00FF" },
  MsgSeparator    = { bg = c.bg_float, fg = "#FF00FF" },
  NonText         = { fg = "#FF00FF", bold = true },
  Normal          = { bg = c.bg },
  NormalFloat     = { bg = c.bg_float },
  FloatBorder     = { bg = c.bg_float, fg = "#FF00FF" },
  NormalNC        = { }, --
  Pmenu           = { bg = c.line, fg = "#FF00FF" },
  PmenuSel        = { bg = c.mg, fg = "#FF00FF" },
  PmenuSbar       = { 'Pmenu' },
  PmenuThumb      = { bg = c.mg },
  Question        = { fg = "#FF00FF", bold = true },
  QuickFixLine    = { 'PmenuSel' },
  Search          = { bg = c.mg, bold = true },
  SignColumn      = { }, --
  SpecialKey      = { fg = "#FF00FF" },
  SpellBad        = { undercurl = true, sp = c.err },
  SpellCap        = { }, --
  SpellLocal      = { }, --
  SpellRare       = { }, --
-- StatusLine      = { bg = c.debug }, --
  StatusLine      = { 'NormalFloat' }, --
  StatusLineNC    = { reverse = true },
  Substitute      = { 'CurSearch' },
  TabLineFill     = { bg = c.bg_float },
  TabLine         = { 'TablineFill', fg = "#FF00FF" },
  TabLineSel      = { 'TablineFill', fg = "#FF00FF", bold = true },
  TermCursor      = { underline = true },
  TermCursorNC    = { 'TermCursor' },
  Title           = { fg = "#FF00FF" },
  Visual          = { bg = c.fold, bold = true },
  VisualNOS       = { }, --
  WarningMsg      = { fg = "#FF00FF" },
Whitespace      = { 'Debug' },
  WildMenu        = { 'Pmenu' },
  WinBar          = { 'NormalFloat' },
  WinBarNC        = { }, --
  WinSeparator    = { fg = "#FF00FF" },

  -- DEPRECATED
  VertSplit       = { 'WinSeparator' },
  FloatTitle      = { fg = "#FF00FF" };


  -- LSP
  LspReferenceText            = { underline = true };
  LspReferenceRead            = { underline = true };
  LspReferenceWrite           = { underline = true };
  LspCodeLens                 = { 'Comment' },
LspCodeLensSeparator        = { fg = "#FF00FF" },
  LspSignatureActiveParameter = { underline = true, bold = true },


  -- Diagnostics
  DiagnosticError             = { fg = "#FF00FF" },
  DiagnosticWarn              = { fg = "#FF00FF" },
  DiagnosticInfo              = { fg = "#FF00FF" },
  DiagnosticHint              = { fg = "#FF00FF" },
  DiagnosticVirtualTextError  = { 'DiagnosticError' },
  DiagnosticVirtualTextWarn   = { 'DiagnosticWarn' },
  DiagnosticVirtualTextInfo   = { 'DiagnosticInfo' },
  DiagnosticVirtualTextHint   = { 'DiagnosticHint' },
  DiagnosticUnderlineError    = { undercurl = true, sp = c.err },
  DiagnosticUnderlineWarn     = { undercurl = true, sp = c.warn },
  DiagnosticUnderlineInfo     = { undercurl = true, sp = c.info },
  DiagnosticUnderlineHint     = { undercurl = true, sp = c.hint },
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
  Comment                 = { fg = "#FFFFFF" },
  Constant                = { fg = "#FFFFFF" },
  String                  = { fg = "#FFFFFF" },
  Character               = { fg = "#FFFFFF" },
  Number                  = { fg = "#FFFFFF" },
  Boolean                 = { fg = "#FFFFFF" },
  Float                   = { fg = "#FFFFFF" },
  Identifier              = { fg = "#FFFFFF" },
  Function                = { fg = "#FFFFFF" },
  Statement               = { fg = "#FFFFFF" },
  Keyword                 = { fg = "#FFFFFF" },
  Conditional             = { fg = "#FFFFFF" },
  Repeat                  = { fg = "#FFFFFF" },
  Label                   = { fg = "#FFFFFF" },
  Operator                = { fg = "#FFFFFF" },
  Exception               = { fg = "#FFFFFF" },
  Include                 = { fg = "#FFFFFF" },
  PreProc                 = { fg = "#FFFFFF" },
  Macro                   = { fg = "#FFFFFF" },
  PreCondit               = { fg = "#FFFFFF" },
  Define                  = { fg = "#FFFFFF" },
  Type                    = { fg = "#FFFFFF" },
  StorageClass            = { fg = "#FFFFFF" },
  Structure               = { fg = "#FFFFFF" },
  Typedef                 = { fg = "#FFFFFF" },
  Special                 = { fg = "#FFFFFF" },
  SpecialChar             = { fg = "#FFFFFF" },
  Tag                     = { fg = "#FFFFFF" },
  Delimiter               = { fg = "#FFFFFF" },
  SpecialComment          = { fg = "#FFFFFF" },
  Debug                   = { fg = "#FFFFFF" },
  Underlined              = { fg = "#FFFFFF" },
  Error                   = { fg = "#FFFFFF" },
  Ignore                  = { fg = "#FFFFFF" };
  Todo                    = { fg = "#FFFFFF" },


  -- TS Filetype Specific
  healthSuccess           = { fg = "#FF00FF", bold = true };
  healthWarning           = { fg = "#FF00FF", bold = true };
  healthError             = { fg = "#FF00FF", bold = true };
  healthHelp              = { fg = "#FF00FF" };
healthBar               = { fg = "#FF00FF" };


  -- Plugins
  LspInfoTitle            = { 'Label' };
  LspInfoList             = { 'Label' };
  LspInfoFiletype         = { 'Type' };
  LspInfoTip              = { 'Comment' };
  LspInfoBorder           = { 'FloatBorder' };

  -- diff
  diffAdded               = { fg = "#FF00FF" };
  diffChanged             = { fg = "#FF00FF" };
  diffRemoved             = { fg = "#FF00FF" };
  diffOldFile             = { bg = c.del };
  diffNewFile             = { bg = c.add };
  diffFile                = { fg = "#FF00FF" };
  diffLine                = { fg = "#FF00FF" };
  diffIndexLine           = { fg = "#FF00FF" };

  -- gitsigns
  GitSignsAdd             = { fg = "#FF00FF" };
  GitSignsAddNr           = { fg = "#FF00FF" };
  GitSignsAddLn           = { fg = "#FF00FF" };
  GitSignsChange          = { fg = "#FF00FF" };
  GitSignsChangeNr        = { fg = "#FF00FF" };
  GitSignsChangeLn        = { fg = "#FF00FF" };
  GitSignsDelete          = { fg = "#FF00FF" };
  GitSignsDeleteNr        = { fg = "#FF00FF" };
  GitSignsDeleteLn        = { fg = "#FF00FF" };

  -- cmp
  CmpItemAbbr             = { fg = "#FF00FF" };
  CmpItemAbbrDeprecated   = { fg = "#FF00FF", strikethrough = true };
  CmpItemAbbrMatch        = { fg = "#FF00FF", bold = true };
  CmpItemAbbrMatchFuzzy   = { fg = "#FF00FF" };
  CmpItemKind             = { };
  CmpItemMenu             = { fg = "#FF00FF" };
  CmpItemKindText         = { fg = "#FF00FF" };
  CmpItemKindMethod       = { fg = "#FF00FF" };
  CmpItemKindFunction     = { fg = "#FF00FF" };
  CmpItemKindConstructor  = { fg = "#FF00FF" };
  CmpItemKindField        = { fg = "#FF00FF" };
  CmpItemKindVariable     = { fg = "#FF00FF" };
  CmpItemKindClass        = { fg = "#FF00FF" };
  CmpItemKindInterface    = { fg = "#FF00FF" };
  CmpItemKindModule       = { fg = "#FF00FF" };
  CmpItemKindProperty     = { fg = "#FF00FF" };
  CmpItemKindUnit         = { fg = "#FF00FF" };
  CmpItemKindValue        = { fg = "#FF00FF" };
  CmpItemKindEnum         = { fg = "#FF00FF" };
  CmpItemKindKeyword      = { fg = "#FF00FF" };
  CmpItemKindSnippet      = { fg = "#FF00FF" };
  CmpItemKindColor        = { fg = "#FF00FF" };
  CmpItemKindFile         = { fg = "#FF00FF" };
  CmpItemKindReference    = { fg = "#FF00FF" };
  CmpItemKindFolder       = { fg = "#FF00FF" };
  CmpItemKindEnumMember   = { fg = "#FF00FF" };
  CmpItemKindConstant     = { fg = "#FF00FF" };
  CmpItemKindStruct       = { fg = "#FF00FF" };
  CmpItemKindEvent        = { fg = "#FF00FF" };
  CmpItemKindOperator     = { fg = "#FF00FF" };
  CmpItemKindTypeParameter= { fg = "#FF00FF" };

  -- scrollview
  ScrollView              = { bg = c.mg };

  -- scrollbar
  ScrollbarHandle         = { 'ScrollView' };
  ScrollbarSearchHandle   = { bg = c.mg, fg = "#FF00FF" };
  ScrollbarSearch         = { fg = "#FF00FF" };
  ScrollbarErrorHandle    = { bg = c.mg, fg = "#FF00FF" };
  ScrollbarError          = { fg = "#FF00FF" };
  ScrollbarWarnHandle     = { bg = c.mg, fg = "#FF00FF" };
  ScrollbarWarn           = { fg = "#FF00FF" };
  ScrollbarInfoHandle     = { bg = c.mg, fg = "#FF00FF" };
  ScrollbarInfo           = { fg = "#FF00FF" };
  ScrollbarHintHandle     = { bg = c.mg, fg = "#FF00FF" };
  ScrollbarHint           = { fg = "#FF00FF" };
  ScrollbarMiscHandle     = { bg = c.mg, fg = "#FF00FF" };
  ScrollbarMisc           = { fg = "#FF00FF" };

  -- nvim-tree
  -- NvimTreeNormal          = { bg = c.bg_alt };
  NvimTreeRootFolder      = { fg = "#FF00FF" };
  NvimTreeFolderIcon      = { fg = "#FF00FF" };
  NvimTreeFileIcon        = { fg = "#FF00FF" };
  NvimTreeSpecialFile     = { fg = "#FF00FF" };
  NvimTreeExecFile        = { bold = true };
  NvimTreeSymlink         = { underline = true };
  NvimTreeIndentMarker    = { fg = "#FF00FF" };
  NvimTreeImageFile       = { fg = "#FF00FF" };
  NvimTreeOpenedFile      = { fg = "#FF00FF" };
  NvimTreeGitDirty        = { fg = "#FF00FF" };
  NvimTreeGitStaged       = { fg = "#FF00FF" };
  NvimTreeGitMerge        = { fg = "#FF00FF" };
  NvimTreeGitRenamed      = { fg = "#FF00FF" };
  NvimTreeGitDeleted      = { fg = "#FF00FF" };
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
  NeoTreeGitIgnored           = { fg = "#FF00FF" };
  NeoTreeGitModified          = { 'NeoTreeModified' };
  NeoTreeGitUnstaged          = { fg = "#FF00FF" };
  NeoTreeGitUntracked         = { fg = "#FF00FF" };
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
NeoTreeEndOfBuffer          = { fg = "#FF00FF" };
  NeoTreeRootName             = { 'Title' };
NeoTreeSymbolicLinkTarget   = { fg = "#FF00FF" };
NeoTreeTitleBar             = { fg = "#FF00FF" };
NeoTreeWindowsHidden        = { fg = "#FF00FF" };
  NeoTreeTabActive            = { 'Normal' };
  NeoTreeTabInactive          = { 'Comment' };
  NeoTreeTabSeparatorActive   = { 'Ignore' };
  NeoTreeTabSeparatorInactive = { 'Ignore' };

  -- vim-quickui
  QuickBG                 = { bg = c.bg_float, fg = "#FF00FF" };
  QuickSel                = { 'Search' };
  QuickKey                = { fg = "#FF00FF" };
  QuickOff                = { fg = "#FF00FF" };
  QuickHelp               = { 'WarningMsg' };

  -- outline
  FocusedSymbol           = { 'Search' };
  SymbolsOutlineConnector = { fg = "#FF00FF" };

  -- telescope
  TelescopeBorder         = { 'FloatBorder' };
  TelescopeMatching       = { fg = "#FF00FF", bold = true };
  TelescopeSelectionCaret = { fg = "#FF00FF", bold = true },
  TelescopeNormal         = { bg = c.bg_float, fg = "#FF00FF" },
  TelescopeSelection      = { 'CursorLine' },
  TelescopeMultiSelection = { 'Type' },
  TelescopeTitle          = { fg = "#FF00FF" };
  TelescopePreviewTitle   = { fg = "#FF00FF" },
  TelescopePreviewNormal  = { },
  TelescopePromptTitle    = { fg = "#FF00FF" },
  TelescopePromptNormal   = { },
  TelescopePromptBorder   = { 'FloatBorder' },

  -- harpoon
  HarpoonBorder           = { 'WinSeparator' };

  -- startup-time
  StartupTimeStartupKey   = { bold = true };
  StartupTimeStartupValue = { bold = true };
  StartupTimeHeader       = { 'Comment' };
  StartupTimeSourcingEvent= { fg = "#FF00FF" };
  StartupTimeOtherEvent   = { fg = "#FF00FF" };
  StartupTimeTime         = { fg = "#FF00FF" };
  StartupTimePercent      = { fg = "#FF00FF" };
  StartupTimePlot         = { fg = "#FF00FF" };

  -- notify
  NotifyERRORBorder       = { 'DiagnosticVirtualTextError' };
  NotifyWARNBorder        = { 'DiagnosticVirtualTextWarn' };
  NotifyINFOBorder        = { 'DiagnosticVirtualTextInfo' };
  NotifyTRACEBorder       = { 'DiagnosticFloatingHint' };
  NotifyDEBUGBorder       = { 'DiagnosticVirtualTextHint' };
  NotifyERRORIcon         = { fg = "#FF00FF" };
  NotifyWARNIcon          = { fg = "#FF00FF" };
  NotifyINFOIcon          = { fg = "#FF00FF" };
  NotifyDEBUGIcon         = { fg = "#FF00FF" };
  NotifyTRACEIcon         = { fg = "#FF00FF" };
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
  UltestPass              = { fg = "#FF00FF" };
  UltestFail              = { fg = "#FF00FF" };
  UltestRunning           = { fg = "#FF00FF" };
  UltestBorder            = { 'FloatBorder' };
  UltestSummaryInfo       = { fg = "#FF00FF" };
  UltestSummaryFile       = { 'UltestSummaryInfo', bold = true};
  UltestSummaryNamespace  = { 'UltestSummaryFile' };

  -- reach
  ReachBorder             = { 'FloatBorder' };
  ReachDirectory          = { 'Directory' };
  ReachModifiedIndicator  = { 'String' };
  ReachHandleBuffer       = { 'String' };
  ReachHandleDelete       = { 'Error' };
  ReachHandleSplit        = { 'Directory' };
  ReachTail               = { fg = "#FF00FF" };
  ReachHandleMarkLocal    = { 'Type' };
  ReachHandleMarkGlobal   = { 'Number' };
  ReachMark               = { 'Normal' };
  ReachMarkLocation       = { 'Comment' };
  ReachHandleTabpage      = { 'TabLineSel' };
  ReachGrayOut            = { 'Comment' };
  ReachMatchExact         = { 'String' };
  ReachPriority           = { 'WarningMsg' };
  ReachCurrent            = { fg = "#FF00FF", bold = true};

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


  -- CUTSOM GROUPS
  -- DebugFg                 = { fg = "#FF00FF" };
  -- DebugBg                 = { bg = debug[1] };
  -- DebugAll                = { bg = debug[1], fg = "#FF00FF" };
  -- NormalAlt               = { bg = c.bg_alt };
  SnippetPassiveIndicator = { 'Comment' };
  SnippetInsertIndicator  = { fg = "#FF00FF" };
  SnippetChoiceIndicator  = { fg = "#FF00FF" };
  -- CursorLineSelect        = { fg = "#FF00FF", bg = c.line, bold = true },
  Camel                   = { 'WarningMsg' };

  ModeNormal              = { fg = "#FF00FF", bold = true };
  ModeInsert              = { fg = "#FF00FF", bold = true };
  ModeVisual              = { fg = "#FF00FF", bold = true };
  ModeControl             = { fg = "#FF00FF", bold = true };
  ModeSelect              = { fg = "#FF00FF", bold = true };
  ModeTerminal            = { fg = "#FF00FF", bold = true };
}

function randomize()
  for k, v in pairs(highlights) do
      local r = math.random(0, 255)
      local g = math.random(0, 255)
      local b = math.random(0, 255)
      local rgb = (r * 0x10000) + (g * 0x100) + b
      v.fg = string.format("#%06x", rgb)
  end
end

--randomize()

set_hls(highlights)
