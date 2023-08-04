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

set_hls(highlights)
