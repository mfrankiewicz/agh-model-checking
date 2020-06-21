" Vim syntax file
" Language:	MCL
" Maintainer:	Syntax Editor Configuration Tool <cadp@inria.fr>
" Last Change:	1.8:MCL+1.13:SECT

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax case ignore
syntax sync lines=250

" Strings
syntax region mclSingleQuotedString start=+'+ end=+'+
syntax region mclDoubleQuotedString start=+"+ end=+"+

" Keywords
syntax keyword mclKeyword among any case choice continue do
syntax keyword mclKeyword else elsif end end_library end_macro exists
syntax keyword mclKeyword exit export for forall from if
syntax keyword mclKeyword in let library loop macro mu
syntax keyword mclKeyword nil nu of on repeat step
syntax keyword mclKeyword tau then to until where while

" Pragmas

" Basic Types
syntax keyword mclType bool nat natset int real char
syntax keyword mclType string

" Constants
syntax keyword mclConstant false true

" Functions
syntax keyword mclFunction abs and concat diff empty equ
syntax keyword mclFunction implies index insert isin isalnum isalpha
syntax keyword mclFunction isdigit islower isupper isxdigit inter length
syntax keyword mclFunction not nth or prefix remove rindex
syntax keyword mclFunction sign substr succ suffix tolower toupper
syntax keyword mclFunction union xor

" Operators
syntax match mclOperator "+"
syntax match mclOperator "-"
syntax match mclOperator "="
syntax match mclOperator "!"
syntax match mclOperator "/"
syntax match mclOperator "\^"
syntax match mclOperator "%"
syntax match mclOperator "|"
syntax match mclOperator "<"
syntax match mclOperator ">"
syntax match mclOperator "\["
syntax match mclOperator "\]"
syntax match mclOperator "@"
syntax match mclOperator "\*"
syntax match mclOperator "?"
syntax match mclOperator "<>"
syntax match mclOperator "<="
syntax match mclOperator ">="
syntax match mclOperator "->"
syntax match mclOperator "-|"

" Comments
syntax region mclComment start=+(\*+ end=+\*)+

" Highlighting
" For Vim version 5.7 and earlier: only when not done already
" For Vim version 5.8 and later: only when an item has no highlighting
if version >= 508 || !exists("did_lnt_syntax_inits")
  if version < 508
    let did_lnt_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink mclComment Comment
  HiLink mclSingleQuotedString Character
  HiLink mclDoubleQuotedString String
  HiLink mclBackQuotedString String
  HiLink mclKeyword Keyword
  HiLink mclPragma PreProc
  HiLink mclType Type
  HiLink mclConstant Boolean
  HiLink mclFunction Tag
  HiLink mclOperator Operator
  delcommand HiLink
endif

let b:current_syntax = "mcl"

