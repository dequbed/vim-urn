" Vim syntax file
" Language: Urn
" Maintainer: Gregor Reitzenstein
" Last Change: 2016-April-19

if exists("b:current_syntax")
  finish
endif

"Urn functions
syn keyword urnFunction ! # -and -or and apply cons const-val debug defmacro defun define
syn keyword urnFunction for if list or pretty progn quasiquote unless when while with 
syn keyword urnFunction % * + - .. / /= < <= = > >= ^ car cdr concat error get-idx 
syn keyword urnFunction getmetatable len# pcall print require tonumber tostring type# unpack xpcall

" Even though these don't actually have a immutable value, *please* do not
" reassign `true`.
syn keyword urnVariable true false nil

"Urn comments
syn match   urnComment ";.*$" contains=@Spell

"catch errors caused by wrong parenthesis and brackets
syn cluster urnAll          contains=urnRegion,urnFunction,urnVariable,urnString,urnComment,urnParenError,urnKey,urnNumber
syn region  urnRegion       matchgroup=Delimiter start="(" skip="|.\{-}|" matchgroup=Delimiter end=")" contains=@urnAll
syn region  urnRegion       matchgroup=Delimiter start="\[" skip="|.\{-}|" matchgroup=Delimiter end="\]" contains=@urnAll
syn region  urnRegion       matchgroup=Delimiter start="{" skip="|.\{-}|" matchgroup=Delimiter end="}" contains=@urnAll
syn match   urnParenError   "]"
syn match   urnParenError   ")"
syn match   urnParenError   "}"

" Urn Key
syn match urnKey "\w\@<![:'][a-z]\+"

"supporting integer numbers
syn match urnNumber "\<[0-9]\d*\>"
syn match urnNumber "-\d\+\>" contains=Number

" Urn Strings
syn region urnString start=+\%(\\\)\@<!"+ skip=+\\[\\"]+ end=+"+ contains=@Spell

syn match urnQuoted "\w\@<![`~,]"

" synchronization
syn sync lines=100

command -nargs=+ HiLink hi def link <args>
HiLink urnComment       Comment
HiLink urnFunction      Statement
HiLink urnVariable      Statement
HiLink urnString        String
HiLink urnNumber        Number
HiLink urnKey           Constant
HiLink urnQuoted        Special
HiLink urnParenError    Error
delcommand HiLink

let b:current_syntax = "urn"

" vim: ts=4 nowrap expandtab:
