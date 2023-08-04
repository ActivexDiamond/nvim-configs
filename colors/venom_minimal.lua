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
  --Untested
  ['@definition.function']          = { fg = "#FF00FF" },
  ['@definition.method']            = { fg = "#FF00FF" },
  ['@name']                         = { fg = "#FF00FF" },
  ['@reference.call']               = { fg = "#FF00FF" },
  ['@local.scope']                  = { fg = "#FF0000" },
  ['@local.definition']             = { fg = "#0000FF" },
  ['@local.reference']              = { fg = "#00ff00" },
  ['@attribute']                    = { fg = "#99999F" },
  ['@method']                       = { fg = "#FF00FF" },
  ['@function.call']                = { fg = "#FF00FF" },
  ['@method.call']                  = { fg = "#FF00FF" },
  ['@preproc']                      = { fg = "#FF6600" },
  ['@_cdef_identifier']             = { fg = "#FF00FF" },
  ['@injection.content']            = { fg = "#FF00FF" },
  ['@fieldconstructor']             = { fg = "#FF00FF" },

  --Generic, found through testing.
--  ['@error']                        = { undercurl = true },
  
  --Tested and works
  ['@constant']                     = { fg = "#FF2C60", bold = true },
  ['@variable']                     = { fg = "#FF3063" },
  ['@parameter']                    = { fg = "#FFB389" },
  ['@field']                        = { fg = "#22ffff" },

  
  ['@function']                     = { fg = "#5AAE76" },
  ['@function.call']                = { fg = "#196B34" },
  ['@keyword.function']             = { fg = "#3AFF7D" ,bold = true },

  ['@method']                       = { fg = "#5F89D9" },                      --5A76AE
  ['@method.call']                  = { fg = "#2845FF" },
  ['@variable.builtin']             = { fg = "#FF0000", italic = true},        --36576D

  ['@function.builtin']             = { fg = "#FF0000" },
  ['@constant.builtin']             = { fg = "#FF0000", bold = true },
  ['@namespace.builtin']            = { fg = "#FF0000" },

  ['@string']                       = { fg = "#AA00AA" },
  ['@number']                       = { fg = "#FF6600" },

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
