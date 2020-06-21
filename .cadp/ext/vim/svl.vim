" Vim syntax file
" Language:	SVL
" Maintainer:	Syntax Editor Configuration Tool <cadp@inria.fr>
" Last Change:	1.8:SVL+1.13:SECT

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
syntax region svlSingleQuotedString start=+'+ end=+'+
syntax region svlDoubleQuotedString start=+"+ end=+"+

" Keywords
syntax keyword svlKeyword abstraction all bag branching but chaos
syntax keyword svlKeyword check comparison cut deadlock divbranching end
syntax keyword svlKeyword expected fifo gate generation hide in
syntax keyword svlKeyword is label labels leaf livelock multiple
syntax keyword svlKeyword node observational of par partial prio
syntax keyword svlKeyword probabilistic property reduction refined rename result
syntax keyword svlKeyword root safety single smart stochastic stop
syntax keyword svlKeyword strong sync
syntax match svlKeyword +tau-compression+
syntax match svlKeyword +tau-confluence+
syntax match svlKeyword +tau-divergence+
syntax match svlKeyword +tau*.a+
syntax keyword svlKeyword total trace user using verify weak
syntax keyword svlKeyword with

" Pragmas
syntax match svlPragma +%.*+

" Basic Types
syntax keyword svlType acyclic bdd bfs dfs fly std

" Constants
syntax keyword svlConstant FALSE TRUE

" Functions
syntax keyword svlFunction aldebaran bcg_min bcg_cmp bisimulator evaluator evaluator3
syntax keyword svlFunction evaluator4 exhibitor fc2tools reductor xtl

" Operators
syntax match svlOperator "\["
syntax match svlOperator "\]"
syntax match svlOperator "{"
syntax match svlOperator "}"
syntax match svlOperator ">"
syntax match svlOperator "="
syntax match svlOperator ":"
syntax match svlOperator "#"
syntax match svlOperator "?"
syntax match svlOperator "=="
syntax match svlOperator ">="
syntax match svlOperator "<="
syntax match svlOperator "|="
syntax match svlOperator "->"
syntax match svlOperator "||"
syntax match svlOperator "|\["
syntax match svlOperator "\]|"
syntax match svlOperator "-||"
syntax match svlOperator "-|\["
syntax match svlOperator "|||"
syntax match svlOperator "-|||"

" Comments
syntax match svlComment +--.*+
syntax region svlComment start=+(\*+ end=+\*)+

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
  HiLink svlComment Comment
  HiLink svlSingleQuotedString Character
  HiLink svlDoubleQuotedString String
  HiLink svlBackQuotedString String
  HiLink svlKeyword Keyword
  HiLink svlPragma PreProc
  HiLink svlType Type
  HiLink svlConstant Boolean
  HiLink svlFunction Tag
  HiLink svlOperator Operator
  delcommand HiLink
endif

let b:current_syntax = "svl"

