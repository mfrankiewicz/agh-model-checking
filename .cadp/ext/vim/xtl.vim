" Vim syntax file
" Language:	XTL
" Maintainer:	Syntax Editor Configuration Tool <cadp@inria.fr>
" Last Change:	1.4:XTL+1.13:SECT

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
syntax region xtlSingleQuotedString start=+'+ end=+'+
syntax region xtlDoubleQuotedString start=+"+ end=+"+
syntax region xtlBackQuotedString start=+`+ end=+`+

" Keywords
syntax keyword xtlKeyword among any apply assert case current
syntax keyword xtlKeyword def else else_if end_assert end_case end_def
syntax keyword xtlKeyword end_exists end_flag end_for end_forall end_func end_if
syntax keyword xtlKeyword end_include end_let end_library end_macro end_type end_use
syntax keyword xtlKeyword exists flag for forall from func
syntax keyword xtlKeyword if in include let library macro
syntax keyword xtlKeyword of otherwise select then to type
syntax keyword xtlKeyword use when where while

" Pragmas
syntax match xtlPragma +!assignedby+
syntax match xtlPragma +!comparedby+
syntax match xtlPragma +!enumeratedby+
syntax match xtlPragma +!implementedby+
syntax match xtlPragma +!printedby+

" Basic Types
syntax keyword xtlType action boolean natural number integer real
syntax keyword xtlType character string raw edge edgeset label
syntax keyword xtlType labelset state stateset

" Constants
syntax keyword xtlConstant empty false full nop null number_of_edges
syntax keyword xtlConstant number_of_labels number_of_states true

" Functions
syntax keyword xtlFunction and and_then card comp diff div
syntax keyword xtlFunction extract fby iff implies includes init
syntax keyword xtlFunction insert inter length mod not or
syntax keyword xtlFunction or_else out pred print printf replace
syntax keyword xtlFunction source succ target union visible

" Operators
syntax match xtlOperator "_"
syntax match xtlOperator "@"
syntax match xtlOperator "->"
syntax match xtlOperator "<|"
syntax match xtlOperator "|>"
syntax match xtlOperator "\.\.\."

" Comments
syntax region xtlComment start=+(\*+ end=+\*)+

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
  HiLink xtlComment Comment
  HiLink xtlSingleQuotedString Character
  HiLink xtlDoubleQuotedString String
  HiLink xtlBackQuotedString String
  HiLink xtlKeyword Keyword
  HiLink xtlPragma PreProc
  HiLink xtlType Type
  HiLink xtlConstant Boolean
  HiLink xtlFunction Tag
  HiLink xtlOperator Operator
  delcommand HiLink
endif

let b:current_syntax = "xtl"

