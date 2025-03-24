"Machine names
"TODO: Be smarter about this. Currently just matches "everything else".
syntax match @variable "\w"
syntax match @variable "\w\d"

" Primitives
syntax match Number "[0123456789.]"
syntax match String /".*"/

" Input
syntax keyword factoryInput input
syntax match factoryInput "\[.*\]"

" Other
syntax match factoryDeps "(.*):"ms=s+1,he=e-2

" Looping
syntax keyword repeat external repeat repeat_count
syntax match repeat "{.*}"

" Conditionals
syntax keyword conditional if

" Language Builtins
syntax keyword @constant.builtin add subtract equal print passthrough

" Literals
syntax keyword Keyword machine
syntax keyword factoryProduct product

" Comments
syntax match Comment "#.*"
