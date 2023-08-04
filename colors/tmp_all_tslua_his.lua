--Gotten from: https://github.com/MunifTanjim/tree-sitter-lua/blob/main/queries/tags.scm

--tags
@definition.function
@definition.method
@name
@reference.call

--locals
@local.scope
@local.definition
@local.reference

--highlights
@repeat
@conditional
@keyword.function
@keyowrd.operator
@operator
@punctuation.delimiter
@punctuation.bracket
@variable
@variable.builtin
@attribute
@constant
@constant.builtin
@boolean
@field
@constructor
@method
@function.call
@method.call
@comment
@preproc
@number
@string
@string.escape
@function.builtin

--injections
@_cdef_identifier
@injection.content

--[[ Plan
built in func                   - X
built in table                  - X
built in func in table          - X italic

global (lowercase)              - red, italic
global (const/upper)            - red, bold

local                           - white
local const/upper               - white? bold   

self                            - cyan
field                           - white?, italic?

function def                    - same as local? white?
function-call                   - yellow

method def                      - same as field?
method call                     - cyan
    
comment                         - green, italic
comment doc                     - orange, italic (same as loop but seperate context enough that they don't overlap').

colon-y stuff                   - cyan 
{ }                             - cyan?
( )                             - yellow?

return                          - deep blue
conditional                     - green
loop                            - orange
label                           - green
other-keyword                   - yellow
bool                            - yellow, bold
and/or                          - ?

string                          - purple
string-escape                   - white

orange - FF6600
yellow - FFFF22
cyan   - 22FFFF
param  - F11F1F
return - 4444FF
repeat - A0FFAA
debug  - AAF00A

--]]
