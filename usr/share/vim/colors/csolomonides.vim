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

" Normal works for the values (=white) and for the terminal, plain output
hi  Normal     ctermfg=white
hi  Cursor     cterm=reverse        ctermbg=red
hi  Comment    ctermfg=116
hi  Constant   ctermfg=blue
hi  Keyword    cterm=bold           ctermfg=lightyellow
hi  PreProc    ctermfg=white
hi  String     ctermfg=13
hi  htmlString cterm=underline      ctermfg=4
hi  Float      ctermfg=9
" Statement works for things like hi
hi  Statement  cterm=bold           ctermfg=lightyellow
" Type is for things like cterm and Type
hi  Type       cterm=bold           ctermfg=brown
hi Identifier   cterm=bold          ctermfg=202
"hi Operator   ctermfg=

hi  Title           cterm=bold          ctermfg=120
hi  htmlH2          cterm=bold          ctermfg=130
hi  htmlH3          cterm=bold          ctermfg=140
hi  htmlH4          cterm=bold          ctermfg=150
hi  NonText         ctermfg=red
hi  htmlItalic      cterm=underline
hi  htmlBold        cterm=bold
hi  htmlBoldItalic  cterm=bold,underline
hi  htmlTagName     cterm=bold          ctermfg=brown
hi  PreProc         cterm=bold          ctermfg=lightyellow
hi  Tags            ctermfg=cyan
hi  SpellBad        cterm=underline     ctermfg=red         ctermbg=NONE
hi  SpellReview     cterm=underline     ctermfg=yellow      ctermbg=NONE
hi  User1           cterm=inverse,bold  cterm=inverse,bold   ctermfg=blue
hi  User2           cterm=inverse,bold  cterm=inverse,bold   ctermfg=green

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
