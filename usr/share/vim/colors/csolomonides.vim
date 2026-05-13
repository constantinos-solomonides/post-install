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
hi  htmlBold        cterm=bold            ctermfg=NONE          ctermbg=NONE
hi  htmlBoldItalic  cterm=bold,underline
hi  htmlTagName     cterm=bold            ctermfg=130
hi  PreProc         cterm=bold            ctermfg=11
hi  Tags            ctermfg=14
hi  SpellBad        cterm=underline       ctermfg=1             ctermbg=NONE
hi  SpellReview     cterm=underline       ctermfg=11            ctermbg=NONE
hi  User1           cterm=inverse,bold    ctermfg=12
hi  User2           cterm=inverse,bold    ctermfg=14
hi  DiffAdd                               ctermbg=29
hi  DiffChange                            ctermbg=13
hi  DiffDelete                            ctermbg=64            ctermfg=15
hi  DiffText        cterm=bold            ctermbg=9             ctermfg=8

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
