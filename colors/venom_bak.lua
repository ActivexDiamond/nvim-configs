
local highlights = {
  -- TREESITTER:
  -- for more visit https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
  -- Misc
  ['@comment']           = { fg = "#FF00FF"},
  ['@error']             = { fg = "#FF00FF"},
  ['@none']              = { fg = "#FF00FF"},
  ['@preproc']           = { fg = "#FF00FF"},
  ['@define']            = fg = "#FF00FF",
  ['@operator']          = { fg = "#FF00FF"},
  -- Punctuation
  ['@punctuation.bracket']    = { fg = "#FF00FF" },
  ['@punctuation.delimiter']  = { fg = "#FF00FF" },
  ['@punctuation.special']    = { fg = "#FF00FF" },
  -- Literals
  ['@string']             = { fg = "#FF00FF"},
  ['@string.regex']       = { fg = "#FF00FF" },
  ['@string.escape']      = { fg = "#FF00FF" },
  ['@string.special']     = { fg = "#FF00FF" },
  ['character']           = { fg = "#FF00FF" },
  ['character.special']   = { fg = "#FF00FF" },
  ['@number']             = { fg = "#FF00FF"},
  ['@boolean']            = { fg = "#FF00FF" },
  ['@float']              = { fg = "#FF00FF" },
  -- Functions
  ['@function']           = { fg = "#FF00FF"},
  ['@function.builtin']   = { fg = "#FF00FF" },
  ['@function.call']      = { fg = "#FF00FF" },
  ['@function.macro']     = { fg = "#FF00FF" },
  ['@method']             = { fg = "#FF00FF" },
  ['@method.call']        = { fg = "#FF00FF" },
  ['@constructor']        = { fg = "#FF00FF" },
  ['@parameter']          = { fg = "#FF00FF" },
  -- Keywords
  ['@keyword']            = { fg = "#FF00FF"},
  ['@keyword.function']   = { fg = "#FF00FF" },
  ['@keyword.operator']   = { fg = "#FF00FF" },
  ['@keyword.return']     = { fg = "#FF00FF" },
  ['@conditional']        = { fg = "#FF00FF" },
  ['@repeat']             = { fg = "#FF00FF" },
  ['@debug']              = { fg = "#FF00FF"},
  ['@label']              = { fg = "#FF00FF" },
  ['@include']            = { fg = "#FF00FF"},
  ['@exception']          = { fg = "#FF00FF" },
  -- Types
  ['@type']               = { fg = "#FF00FF"},
  ['@type.builtin']       = { fg = "#FF00FF" },
  ['@type.definition']    = { fg = "#FF00FF" },
  ['@type.qualifier']     = { fg = "#FF00FF" },
  ['@storageclass']       = { fg = "#FF00FF" },
  ['@attribute']          = { fg = "#FF00FF" },
  ['@field']              = { fg = "#FF00FF" },
  ['@property']           = { fg = "#FF00FF" },
  -- Identifiers
  ['@variable']           = { fg = "#FF00FF"}, -- c.variable,
  ['@variable.builtin']   = { fg = "#FF00FF" },
  ['@constant']           = { fg = "#FF00FF"},
  ['@constant.builtin']   = { fg = "#FF00FF" },
  ['@constant.macro']     = { fg = "#FF00FF" },
  ['@namespace']          = { fg = "#FF00FF" },
  ['@symbol']             = { fg = "#FF00FF" },
  -- Text
  ['@text']                   = { fg = "#FF00FF"},
  ['@text.strong']            = { bold = true },
  ['@text.emphasis']          = { italic = true },
  ['@text.underline']         = { underline = true },
  ['@text.strike']            = { strikethrough = true },
  ['@text.title']             = { bold = true },
  ['@text.literal']           = { fg = "#FF00FF" },
  ['@text.uri']               = { underline = true, fg = "#FF00FF"},
  ['@text.math']              = { fg = "#FF00FF" },
  ['@text.environment']       = { fg = "#FF00FF" },
  ['@text.environment.name']  = { fg = "#FF00FF" },
  ['@text.reference']         = { fg = "#FF00FF" },
  ['@text.todo']              = { fg = "#FF00FF"},
  ['@text.note']              = { fg = "#FF00FF"},
  ['@text.warning']           = { fg = "#FF00FF"},
  ['@text.danger']            = { bg = c.err, fg = "#FF00FF"},
  ['@text.diff.add']          = { fg = "#FF00FF"},
  ['@text.diff.delete']       = { fg = "#FF00FF"},
  -- Tags
  ['@tag']                = { fg = "#FF00FF" },
  ['@tag.attribute']      = { fg = "#FF00FF" },
  ['@tag.delimiter']      = { fg = "#FF00FF" },

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
  DiffAdd         = { fg = "#FF00FF"},
  DiffChange      = { fg = "#FF00FF"},
  DiffDelete      = { fg = "#FF00FF"},
  DiffText        = { fg = "#FF00FF"},
  Directory       = { }, --
  EndOfBuffer     = { }, --
  ErrorMsg        = { fg = "#FF00FF"},
  FoldColumn      = { }, --
  Folded          = { fg = "#FF00FF", bold = true },
  lCursor         = { }, --
  IncSearch       = { 'Search' },
  LineNr          = { fg = "#FF00FF", italic = true },
  LineNrAbove     = { }, --
  LineNrBelow     = { }, --
  MatchParen      = { bold = true },
  ModeMsg         = { fg = "#FF00FF", bold = true },
  MoreMsg         = { fg = "#FF00FF"},
  MsgArea         = { fg = "#FF00FF"},
  MsgSeparator    = { bg = c.bg_float, fg = "#FF00FF"},
  NonText         = { fg = "#FF00FF", bold = true },
  Normal          = { bg = c.bg },
  NormalFloat     = { bg = c.bg_float },
  FloatBorder     = { bg = c.bg_float, fg = "#FF00FF"},
  NormalNC        = { }, --
  Pmenu           = { bg = c.line, fg = "#FF00FF"},
  PmenuSel        = { bg = c.mg, fg = "#FF00FF"},
  PmenuSbar       = { 'Pmenu' },
  PmenuThumb      = { bg = c.mg },
  Question        = { fg = "#FF00FF", bold = true },
  QuickFixLine    = { 'PmenuSel' },
  Search          = { bg = c.mg, bold = true },
  SignColumn      = { }, --
  SpecialKey      = { fg = "#FF00FF"},
  SpellBad        = { undercurl = true, sp = c.err },
  SpellCap        = { }, --
  SpellLocal      = { }, --
  SpellRare       = { }, --
-- StatusLine      = { bg = c.debug }, --
  StatusLine      = { 'NormalFloat' }, --
  StatusLineNC    = { reverse = true },
  Substitute      = { 'CurSearch' },
  TabLineFill     = { bg = c.bg_float },
  TabLine         = { 'TablineFill', fg = "#FF00FF"},
  TabLineSel      = { 'TablineFill', fg = "#FF00FF", bold = true },
  TermCursor      = { underline = true },
  TermCursorNC    = { 'TermCursor' },
  Title           = { fg = "#FF00FF" },
  Visual          = { bg = c.fold, bold = true },
  VisualNOS       = { }, --
  WarningMsg      = { fg = "#FF00FF"},
Whitespace      = { 'Debug' },
  WildMenu        = { 'Pmenu' },
  WinBar          = { 'NormalFloat' },
  WinBarNC        = { }, --
  WinSeparator    = { fg = "#FF00FF"},

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
  DiagnosticError             = { fg = "#FF00FF"},
  DiagnosticWarn              = { fg = "#FF00FF"},
  DiagnosticInfo              = { fg = "#FF00FF"},
  DiagnosticHint              = { fg = "#FF00FF"},
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
  Comment                 = { fg = "#FF00FF" },
  Constant                = { fg = "#FF00FF" },
  String                  = { fg = "#FF00FF" },
  Character               = { fg = "#FF00FF" },
  Number                  = { fg = "#FF00FF" },
  Boolean                 = { fg = "#FF00FF" },
  Float                   = { fg = "#FF00FF" },
  Identifier              = { fg = "#FF00FF" },
  Function                = { fg = "#FF00FF" },
  Statement               = { fg = "#FF00FF" },
  Keyword                 = { fg = "#FF00FF" },
  Conditional             = { fg = "#FF00FF" },
  Repeat                  = { fg = "#FF00FF" },
  Label                   = { fg = "#FF00FF" },
  Operator                = { fg = "#FF00FF" },
  Exception               = { fg = "#FF00FF" },
  Include                 = { fg = "#FF00FF" },
  PreProc                 = { fg = "#FF00FF" },
  Macro                   = { fg = "#FF00FF" },
  PreCondit               = { fg = "#FF00FF" },
  Define                  = { fg = "#FF00FF" },
  Type                    = { fg = "#FF00FF" },
  StorageClass            = { fg = "#FF00FF" },
  Structure               = { fg = "#FF00FF" },
  Typedef                 = { fg = "#FF00FF" },
  Special                 = { fg = "#FF00FF" },
  SpecialChar             = { fg = "#FF00FF" },
  Tag                     = { fg = "#FF00FF" },
  Delimiter               = { fg = "#FF00FF" },
  SpecialComment          = { fg = "#FF00FF" },
  Debug                   = { fg = "#FF00FF" },
  Underlined              = { fg = "#FF00FF" },
  Error                   = { fg = "#FF00FF" },
  Ignore                  = { fg = "#FF00FF"};
  Todo                    = { fg = "#FF00FF" },


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
  diffAdded               = { fg = "#FF00FF"};
  diffChanged             = { fg = "#FF00FF"};
  diffRemoved             = { fg = "#FF00FF"};
  diffOldFile             = { bg = c.del };
  diffNewFile             = { bg = c.add };
  diffFile                = { fg = "#FF00FF"};
  diffLine                = { fg = "#FF00FF"};
  diffIndexLine           = { fg = "#FF00FF"};

  -- gitsigns
  GitSignsAdd             = { fg = "#FF00FF"};
  GitSignsAddNr           = { fg = "#FF00FF"};
  GitSignsAddLn           = { fg = "#FF00FF"};
  GitSignsChange          = { fg = "#FF00FF"};
  GitSignsChangeNr        = { fg = "#FF00FF"};
  GitSignsChangeLn        = { fg = "#FF00FF"};
  GitSignsDelete          = { fg = "#FF00FF"};
  GitSignsDeleteNr        = { fg = "#FF00FF"};
  GitSignsDeleteLn        = { fg = "#FF00FF"};

  -- cmp
  CmpItemAbbr             = { fg = "#FF00FF"};
  CmpItemAbbrDeprecated   = { fg = "#FF00FF", strikethrough = true };
  CmpItemAbbrMatch        = { fg = "#FF00FF", bold = true };
  CmpItemAbbrMatchFuzzy   = { fg = "#FF00FF"};
  CmpItemKind             = { };
  CmpItemMenu             = { fg = "#FF00FF"};
  CmpItemKindText         = { fg = "#FF00FF"};
  CmpItemKindMethod       = { fg = "#FF00FF"};
  CmpItemKindFunction     = { fg = "#FF00FF"};
  CmpItemKindConstructor  = { fg = "#FF00FF"};
  CmpItemKindField        = { fg = "#FF00FF"};
  CmpItemKindVariable     = { fg = "#FF00FF"};
  CmpItemKindClass        = { fg = "#FF00FF"};
  CmpItemKindInterface    = { fg = "#FF00FF"};
  CmpItemKindModule       = { fg = "#FF00FF"};
  CmpItemKindProperty     = { fg = "#FF00FF"};
  CmpItemKindUnit         = { fg = "#FF00FF"};
  CmpItemKindValue        = { fg = "#FF00FF"};
  CmpItemKindEnum         = { fg = "#FF00FF"};
  CmpItemKindKeyword      = { fg = "#FF00FF"};
  CmpItemKindSnippet      = { fg = "#FF00FF"};
  CmpItemKindColor        = { fg = "#FF00FF"};
  CmpItemKindFile         = { fg = "#FF00FF"};
  CmpItemKindReference    = { fg = "#FF00FF"};
  CmpItemKindFolder       = { fg = "#FF00FF"};
  CmpItemKindEnumMember   = { fg = "#FF00FF"};
  CmpItemKindConstant     = { fg = "#FF00FF"};
  CmpItemKindStruct       = { fg = "#FF00FF"};
  CmpItemKindEvent        = { fg = "#FF00FF"};
  CmpItemKindOperator     = { fg = "#FF00FF"};
  CmpItemKindTypeParameter= { fg = "#FF00FF"};

  -- scrollview
  ScrollView              = { bg = c.mg };

  -- scrollbar
  ScrollbarHandle         = { 'ScrollView' };
  ScrollbarSearchHandle   = { bg = c.mg, fg = "#FF00FF"};
  ScrollbarSearch         = { fg = "#FF00FF"};
  ScrollbarErrorHandle    = { bg = c.mg, fg = "#FF00FF"};
  ScrollbarError          = { fg = "#FF00FF"};
  ScrollbarWarnHandle     = { bg = c.mg, fg = "#FF00FF"};
  ScrollbarWarn           = { fg = "#FF00FF"};
  ScrollbarInfoHandle     = { bg = c.mg, fg = "#FF00FF"};
  ScrollbarInfo           = { fg = "#FF00FF"};
  ScrollbarHintHandle     = { bg = c.mg, fg = "#FF00FF"};
  ScrollbarHint           = { fg = "#FF00FF"};
  ScrollbarMiscHandle     = { bg = c.mg, fg = "#FF00FF"};
  ScrollbarMisc           = { fg = "#FF00FF"};

  -- nvim-tree
  -- NvimTreeNormal          = { bg = c.bg_alt };
  NvimTreeRootFolder      = { fg = "#FF00FF"};
  NvimTreeFolderIcon      = { fg = "#FF00FF"};
  NvimTreeFileIcon        = { fg = "#FF00FF"};
  NvimTreeSpecialFile     = { fg = "#FF00FF"};
  NvimTreeExecFile        = { bold = true };
  NvimTreeSymlink         = { underline = true };
  NvimTreeIndentMarker    = { fg = "#FF00FF"};
  NvimTreeImageFile       = { fg = "#FF00FF"};
  NvimTreeOpenedFile      = { fg = "#FF00FF"};
  NvimTreeGitDirty        = { fg = "#FF00FF"};
  NvimTreeGitStaged       = { fg = "#FF00FF"};
  NvimTreeGitMerge        = { fg = "#FF00FF"};
  NvimTreeGitRenamed      = { fg = "#FF00FF"};
  NvimTreeGitDeleted      = { fg = "#FF00FF"};
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
  NeoTreeGitIgnored           = { fg = "#FF00FF"};
  NeoTreeGitModified          = { 'NeoTreeModified' };
  NeoTreeGitUnstaged          = { fg = "#FF00FF"};
  NeoTreeGitUntracked         = { fg = "#FF00FF"};
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
  QuickBG                 = { bg = c.bg_float, fg = "#FF00FF"};
  QuickSel                = { 'Search' };
  QuickKey                = { fg = "#FF00FF"};
  QuickOff                = { fg = "#FF00FF"};
  QuickHelp               = { 'WarningMsg' };

  -- outline
  FocusedSymbol           = { 'Search' };
  SymbolsOutlineConnector = { fg = "#FF00FF"};

  -- telescope
  TelescopeBorder         = { 'FloatBorder' };
  TelescopeMatching       = { fg = "#FF00FF", bold = true };
  TelescopeSelectionCaret = { fg = "#FF00FF", bold = true },
  TelescopeNormal         = { bg = c.bg_float, fg = "#FF00FF"},
  TelescopeSelection      = { 'CursorLine' },
  TelescopeMultiSelection = { 'Type' },
  TelescopeTitle          = { fg = "#FF00FF"};
  TelescopePreviewTitle   = { fg = "#FF00FF"},
  TelescopePreviewNormal  = { },
  TelescopePromptTitle    = { fg = "#FF00FF"},
  TelescopePromptNormal   = { },
  TelescopePromptBorder   = { 'FloatBorder' },

  -- harpoon
  HarpoonBorder           = { 'WinSeparator' };

  -- startup-time
  StartupTimeStartupKey   = { bold = true };
  StartupTimeStartupValue = { bold = true };
  StartupTimeHeader       = { 'Comment' };
  StartupTimeSourcingEvent= { fg = "#FF00FF"};
  StartupTimeOtherEvent   = { fg = "#FF00FF"};
  StartupTimeTime         = { fg = "#FF00FF"};
  StartupTimePercent      = { fg = "#FF00FF"};
  StartupTimePlot         = { fg = "#FF00FF"};

  -- notify
  NotifyERRORBorder       = { 'DiagnosticVirtualTextError' };
  NotifyWARNBorder        = { 'DiagnosticVirtualTextWarn' };
  NotifyINFOBorder        = { 'DiagnosticVirtualTextInfo' };
  NotifyTRACEBorder       = { 'DiagnosticFloatingHint' };
  NotifyDEBUGBorder       = { 'DiagnosticVirtualTextHint' };
  NotifyERRORIcon         = { fg = "#FF00FF"};
  NotifyWARNIcon          = { fg = "#FF00FF"};
  NotifyINFOIcon          = { fg = "#FF00FF"};
  NotifyDEBUGIcon         = { fg = "#FF00FF"};
  NotifyTRACEIcon         = { fg = "#FF00FF"};
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
  UltestPass              = { fg = "#FF00FF"};
  UltestFail              = { fg = "#FF00FF"};
  UltestRunning           = { fg = "#FF00FF"};
  UltestBorder            = { 'FloatBorder' };
  UltestSummaryInfo       = { fg = "#FF00FF"};
  UltestSummaryFile       = { 'UltestSummaryInfo', bold = true};
  UltestSummaryNamespace  = { 'UltestSummaryFile' };

  -- reach
  ReachBorder             = { 'FloatBorder' };
  ReachDirectory          = { 'Directory' };
  ReachModifiedIndicator  = { 'String' };
  ReachHandleBuffer       = { 'String' };
  ReachHandleDelete       = { 'Error' };
  ReachHandleSplit        = { 'Directory' };
  ReachTail               = { fg = "#FF00FF"};
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
  -- DebugFg                 = { fg = "#FF00FF"};
  -- DebugBg                 = { bg = debug[1] };
  -- DebugAll                = { bg = debug[1], fg = "#FF00FF"};
  -- NormalAlt               = { bg = c.bg_alt };
  SnippetPassiveIndicator = { 'Comment' };
  SnippetInsertIndicator  = { fg = "#FF00FF"};
  SnippetChoiceIndicator  = { fg = "#FF00FF"};
  -- CursorLineSelect        = { fg = "#FF00FF", bg = c.line, bold = true },
  Camel                   = { 'WarningMsg' };

  ModeNormal              = { fg = "#FF00FF", bold = true };
  ModeInsert              = { fg = "#FF00FF", bold = true };
  ModeVisual              = { fg = "#FF00FF", bold = true };
  ModeControl             = { fg = "#FF00FF", bold = true };
  ModeSelect              = { fg = "#FF00FF", bold = true };
  ModeTerminal            = { fg = "#FF00FF", bold = true };
}

--[=[
 vim.cmd [[
   augroup misc_highlighs
   au!

   autocmd BufEnter log,*.log call SetLogHighlights()
   function SetLogHighlights()
     syn region logHead start=/^\[/ end=/\]/ contains=logInfo,logWarn,logError

     syn keyword logInfo INFO
     syn keyword logWarn WARN START
     syn keyword logError ERROR

     hi link logInfo DiagnosticInfo
     hi link logWarn DiagnosticWarn
     hi link logError DiagnosticError

     hi link logHead Comment
   endfunction
   augroup misc_highlighs
 ]]
--]=]
set_hls(highlights)
