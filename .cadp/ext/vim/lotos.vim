" Vim syntax file
" Language:	LOTOS
" Maintainer:	Syntax Editor Configuration Tool <cadp@inria.fr>
" Last Change:	1.7:LOTOS+1.13:SECT

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

" Keywords
syntax keyword lotosKeyword accept actualizedby any behaviour behavior choice
syntax keyword lotosKeyword endlib endproc endspec endtype eqns exit
syntax keyword lotosKeyword for forall formaleqns formalopns formalsorts hide
syntax keyword lotosKeyword i in is let library noexit
syntax keyword lotosKeyword of ofsort opnnames opns par process
syntax keyword lotosKeyword renamedby sortnames sorts specification stop type
syntax keyword lotosKeyword using where

" Pragmas
syntax keyword lotosPragma atomic comparedby constructor enumeratedby external implementedby
syntax keyword lotosPragma iteratedby printedby

" Basic Types
syntax keyword lotosType BasicNaturalNumber Bit BitNatRepr BitString Bool Boolean
syntax keyword lotosType DecDigit DecNatRepr DecString HexDigit HexNatRepr HexString
syntax keyword lotosType NatRepresentations Nat NaturalNumber OctDigit Octet OctetString
syntax keyword lotosType OctNatRepr OctString Set String

" Constants
syntax keyword lotosConstant false true

" Functions
syntax keyword lotosFunction and Bit1 Bit2 Bit3 Bit4 Bit5
syntax keyword lotosFunction Bit6 Bit7 Bit8 Card eq ge
syntax keyword lotosFunction gt iff implies Includes Insert Ints
syntax keyword lotosFunction IsIn IsSubsetOf le Length lt Minus
syntax keyword lotosFunction NatNum ne not NotIn or Remove
syntax keyword lotosFunction Reverse Succ Union xor

" Operators
syntax match lotosOperator "<"
syntax match lotosOperator ">"
syntax match lotosOperator "+"
syntax match lotosOperator "-"
syntax match lotosOperator "/"
syntax match lotosOperator "\*"
syntax match lotosOperator "!"
syntax match lotosOperator "?"
syntax match lotosOperator ";"
syntax match lotosOperator "\*\*"
syntax match lotosOperator "=="
syntax match lotosOperator "<>"
syntax match lotosOperator "<="
syntax match lotosOperator ">="
syntax match lotosOperator "=>"
syntax match lotosOperator ">>"
syntax match lotosOperator "\[>"
syntax match lotosOperator "||"
syntax match lotosOperator "|\["
syntax match lotosOperator "\]|"
syntax match lotosOperator "\[\]"
syntax match lotosOperator "|||"

" Comments
syntax region lotosComment start=+(\*+ end=+\*)+

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
  HiLink lotosComment Comment
  HiLink lotosSingleQuotedString Character
  HiLink lotosDoubleQuotedString String
  HiLink lotosBackQuotedString String
  HiLink lotosKeyword Keyword
  HiLink lotosPragma PreProc
  HiLink lotosType Type
  HiLink lotosConstant Boolean
  HiLink lotosFunction Tag
  HiLink lotosOperator Operator
  delcommand HiLink
endif

let b:current_syntax = "lotos"

