" Vim syntax file
" Language:	NUPN
" Maintainer:	Syntax Editor Configuration Tool <cadp@inria.fr>
" Last Change:	1.3:NUPN+1.13:SECT

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
syntax keyword nupnKeyword initial labels place places root transitions
syntax keyword nupnKeyword unit units

" Pragmas
syntax match nupnPragma +!creator+
syntax match nupnPragma +!multiple_arcs+
syntax match nupnPragma +!multiple_initial_tokens+
syntax match nupnPragma +!unit_safe+

" Basic Types

" Constants

" Functions

" Operators
syntax match nupnOperator "#"
syntax match nupnOperator "\.\.\."

" Comments

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
  HiLink nupnComment Comment
  HiLink nupnSingleQuotedString Character
  HiLink nupnDoubleQuotedString String
  HiLink nupnBackQuotedString String
  HiLink nupnKeyword Keyword
  HiLink nupnPragma PreProc
  HiLink nupnType Type
  HiLink nupnConstant Boolean
  HiLink nupnFunction Tag
  HiLink nupnOperator Operator
  delcommand HiLink
endif

let b:current_syntax = "nupn"

