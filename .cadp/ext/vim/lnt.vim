" Vim syntax file
" Language:	LNT
" Maintainer:	Syntax Editor Configuration Tool <cadp@inria.fr>
" Last Change:	1.25:LNT+1.13:SECT

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
syntax region lntSingleQuotedString start=+'+ end=+'+
syntax region lntDoubleQuotedString start=+"+ end=+"+

" Keywords
syntax keyword lntKeyword access any array as assert break
syntax keyword lntKeyword by case channel disrupt else elsif
syntax keyword lntKeyword end ensure eval for function hide
syntax keyword lntKeyword if in is list loop module
syntax keyword lntKeyword null of only out par process
syntax keyword lntKeyword raise range require result return select
syntax keyword lntKeyword set sorted stop then type use
syntax keyword lntKeyword var where while with

" Pragmas
syntax match lntPragma +!bits+
syntax match lntPragma +!card+
syntax match lntPragma +!nat_bits+
syntax match lntPragma +!nat_inf+
syntax match lntPragma +!nat_sup+
syntax match lntPragma +!nat_check+
syntax match lntPragma +!int_bits+
syntax match lntPragma +!int_inf+
syntax match lntPragma +!int_sup+
syntax match lntPragma +!int_check+
syntax match lntPragma +!num_bits+
syntax match lntPragma +!num_card+
syntax match lntPragma +!string_card+
syntax match lntPragma +!comparedby+
syntax match lntPragma +!external+
syntax match lntPragma +!implementedby+
syntax match lntPragma +!iteratedby+
syntax match lntPragma +!printedby+
syntax match lntPragma +!representedby+
syntax match lntPragma +!version+

" Basic Types
syntax keyword lntType bool nat int real char string

" Constants
syntax keyword lntConstant false true

" Functions
syntax keyword lntFunction abs and and_then append card cons
syntax keyword lntFunction delete diff div element empty eq
syntax keyword lntFunction first gcd ge get gt head
syntax keyword lntFunction iff implies index insert inter IntToNat
syntax keyword lntFunction is_empty IsLower IsUpper IsAlpha IsAlnum IsDigit
syntax keyword lntFunction IsXDigit last le length lt max
syntax keyword lntFunction member min mod NatToInt ne neg
syntax keyword lntFunction nil not nth or ord or_else
syntax keyword lntFunction pos pred prefix rem remove reverse
syntax keyword lntFunction rindex scm set sign substr succ
syntax keyword lntFunction suffix tail ToLower ToUpper union update
syntax keyword lntFunction val xor

" Operators
syntax match lntOperator "="
syntax match lntOperator "<"
syntax match lntOperator ">"
syntax match lntOperator "|"
syntax match lntOperator "+"
syntax match lntOperator "-"
syntax match lntOperator "/"
syntax match lntOperator "\*"
syntax match lntOperator "?"
syntax match lntOperator ";"
syntax match lntOperator "\*\*"
syntax match lntOperator "=="
syntax match lntOperator "<>"
syntax match lntOperator "/="
syntax match lntOperator "<="
syntax match lntOperator ">="
syntax match lntOperator "=>"
syntax match lntOperator "||"
syntax match lntOperator "\[\]"
syntax match lntOperator "->"

" Comments
syntax match lntComment +--.*+
syntax region lntComment start=+(\*+ end=+\*)+

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
  HiLink lntComment Comment
  HiLink lntSingleQuotedString Character
  HiLink lntDoubleQuotedString String
  HiLink lntBackQuotedString String
  HiLink lntKeyword Keyword
  HiLink lntPragma PreProc
  HiLink lntType Type
  HiLink lntConstant Boolean
  HiLink lntFunction Tag
  HiLink lntOperator Operator
  delcommand HiLink
endif

let b:current_syntax = "lnt"

