" Vim syntax file
" Language:	EXP
" Maintainer:	Syntax Editor Configuration Tool <cadp@inria.fr>
" Last Change:	2.6:EXP+1.13:SECT

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
syntax region expSingleQuotedString start=+'+ end=+'+
syntax region expDoubleQuotedString start=+"+ end=+"+

" Keywords
syntax keyword expKeyword all any behavior behaviour but comm
syntax keyword expKeyword cut end gate hide in par
syntax keyword expKeyword prio rename using

" Pragmas

" Basic Types
syntax keyword expType ccs csp elotos lotos mcrl

" Constants

" Functions
syntax keyword expFunction label multiple partial single total

" Operators
syntax match expOperator "\["
syntax match expOperator "\]"
syntax match expOperator "{"
syntax match expOperator "}"
syntax match expOperator ">"
syntax match expOperator "="
syntax match expOperator "|"
syntax match expOperator "/"
syntax match expOperator "\*"
syntax match expOperator "#"
syntax match expOperator "_"
syntax match expOperator "->"

" Comments
syntax match expComment +--.*+
syntax region expComment start=+(\*+ end=+\*)+

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
  HiLink expComment Comment
  HiLink expSingleQuotedString Character
  HiLink expDoubleQuotedString String
  HiLink expBackQuotedString String
  HiLink expKeyword Keyword
  HiLink expPragma PreProc
  HiLink expType Type
  HiLink expConstant Boolean
  HiLink expFunction Tag
  HiLink expOperator Operator
  delcommand HiLink
endif

let b:current_syntax = "exp"

