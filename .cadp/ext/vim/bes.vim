" Vim syntax file
" Language:	BES
" Maintainer:	Syntax Editor Configuration Tool <cadp@inria.fr>
" Last Change:	1.3:BES+1.13:SECT

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
syntax keyword besKeyword block end is mode mu nu
syntax keyword besKeyword unique

" Pragmas

" Basic Types

" Constants
syntax keyword besConstant false true

" Functions
syntax keyword besFunction and or

" Operators

" Comments
syntax region besComment start=+(\*+ end=+\*)+

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
  HiLink besComment Comment
  HiLink besSingleQuotedString Character
  HiLink besDoubleQuotedString String
  HiLink besBackQuotedString String
  HiLink besKeyword Keyword
  HiLink besPragma PreProc
  HiLink besType Type
  HiLink besConstant Boolean
  HiLink besFunction Tag
  HiLink besOperator Operator
  delcommand HiLink
endif

let b:current_syntax = "bes"

