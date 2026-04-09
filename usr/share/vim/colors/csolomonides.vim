" Vim color file
" Maintainer: Constantinos SOLOMONIDES <MY_EMAIL_ADDRESS>
" URL:
" Version: 0.1
"
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
    syntax reset
    endif
endif
let g:colors_name="csolomonides"

hi  Normal          ctermfg=7
hi  Cursor          cterm=reverse         ctermbg=1
hi  Comment         ctermfg=116
hi  Constant        ctermfg=12
hi  Keyword         cterm=bold            ctermfg=11
hi  PreProc         ctermfg=7
hi  String          ctermfg=13
hi  htmlString      cterm=underline       ctermfg=4
hi  Float           ctermfg=9
hi  Statement       cterm=bold            ctermfg=10
hi  Type            cterm=bold            ctermfg=130
hi  Identifier      cterm=bold            ctermfg=202
hi  Title           cterm=bold            ctermfg=120
hi  htmlH2          cterm=bold            ctermfg=130
hi  htmlH3          cterm=bold            ctermfg=140
hi  htmlH4          cterm=bold            ctermfg=150
hi  NonText         ctermfg=1
hi  htmlItalic      cterm=underline
hi  htmlBold        cterm=bold
hi  htmlBoldItalic  cterm=bold,underline
hi  htmlTagName     cterm=bold            ctermfg=130
hi  PreProc         cterm=bold            ctermfg=11
hi  Tags            ctermfg=14
hi  SpellBad        cterm=underline       ctermfg=1           ctermbg=NONE
hi  SpellReview     cterm=underline       ctermfg=11          ctermbg=NONE
hi  User1           cterm=inverse,bold    cterm=inverse,bold  ctermfg=12
hi  User2           cterm=inverse,bold    cterm=inverse,bold  ctermfg=14

hi link Character               Constant
hi link Number                  Constant
hi link Float                   Constant
hi link Function                Statement
hi link Conditional             Statement
hi link Repeat                  Statement
hi link Label                   Statement
hi link Operator                Statement
hi link Keyword                 Statement
hi link Include                 PreProc
hi link Define                  PreProc
hi link Macro                   PreProc
hi link PreCondit               PreProc
hi link StorageClass            Type
hi link Structure               Type
hi link Typedef                 Type
hi link Tag                     Tags
hi link markdownH1Delimiter     Title
hi link markdownH2Delimiter     htmlH2
hi link markdownH3Delimiter     htmlH3
hi link markdownH4Delimiter     htmlH4
hi! link SpellLocal             SpellReview
hi! link SpellRare              SpellReview

" Color reference.
" hi!  Example1    cterm=bold  ctermfg=1    |  syn  match  Example1    /Example1/    "  Red
" hi!  Example2    cterm=bold  ctermfg=2    |  syn  match  Example2    /Example2/    "  Olive   green
" hi!  Example3    cterm=bold  ctermfg=3    |  syn  match  Example3    /Example3/    "  Yellow
" hi!  Example4    cterm=bold  ctermfg=4    |  syn  match  Example4    /Example4/    "  Light   blue
" hi!  Example5    cterm=bold  ctermfg=5    |  syn  match  Example5    /Example5/    "  Purple
" hi!  Example6    cterm=bold  ctermfg=6    |  syn  match  Example6    /Example6/    "  Light   turquoise
" hi!  Example7    cterm=bold  ctermfg=7    |  syn  match  Example7    /Example7/    "  Very    light yellow
" hi!  Example8    cterm=bold  ctermfg=8    |  syn  match  Example8    /Example8/    "  Black   black
" hi!  Example9    cterm=bold  ctermfg=9    |  syn  match  Example9    /Example9/    "  Bright  red
" hi!  Example10   cterm=bold  ctermfg=10   |  syn  match  Example10   /Example10/   "  Light   green
" hi!  Example11   cterm=bold  ctermfg=11   |  syn  match  Example11   /Example11/   "  Light   yellow
" hi!  Example12   cterm=bold  ctermfg=12   |  syn  match  Example12   /Example12/   "  Light   blue
" hi!  Example13   cterm=bold  ctermfg=13   |  syn  match  Example13   /Example13/   "  Light   purple / rose
" hi!  Example14   cterm=bold  ctermfg=14   |  syn  match  Example14   /Example14/   "  Light   green
" hi!  Example130  cterm=bold  ctermfg=130  |  syn  match  Example130  /Example130/  "  Brown
