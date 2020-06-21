" Vim syntax file
" Language:	RBC
" Maintainer:	Syntax Editor Configuration Tool <cadp@inria.fr>
" Last Change:	1.3:RBC+1.13:SECT

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax case match
syntax sync lines=250

" Strings

" Keywords
syntax keyword rbcKeyword alternation_free equation_length false_constant_ratio local_variable_ratio number_of_blocks number_of_variables
syntax keyword rbcKeyword or_variable_alternation or_variable_ratio shape sign solve_mode strategy
syntax keyword rbcKeyword unique_resolution variable_ratio

" Pragmas

" Basic Types

" Constants

" Functions

" Operators
syntax match rbcOperator "\["
syntax match rbcOperator "\]"
syntax match rbcOperator "="
syntax match rbcOperator "\.\."

" Comments
syntax match rbcComment +#.*+

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
  HiLink rbcComment Comment
  HiLink rbcSingleQuotedString Character
  HiLink rbcDoubleQuotedString String
  HiLink rbcBackQuotedString String
  HiLink rbcKeyword Keyword
  HiLink rbcPragma PreProc
  HiLink rbcType Type
  HiLink rbcConstant Boolean
  HiLink rbcFunction Tag
  HiLink rbcOperator Operator
  delcommand HiLink
endif

let b:current_syntax = "rbc"

