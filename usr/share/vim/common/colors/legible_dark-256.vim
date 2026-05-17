" Vim color file
" Dark version, 256-colors
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
let g:colors_name="legible_dark-256"

hi  Normal              ctermfg=7
hi  Cursor                              ctermbg=1     cterm=reverse
hi  Comment             ctermfg=116
hi  Constant            ctermfg=12
hi  Keyword             ctermfg=11                    cterm=bold
hi  PreProc             ctermfg=7
hi  String              ctermfg=13
hi  htmlString          ctermfg=4                     cterm=underline
hi  Float               ctermfg=9
hi  Statement           ctermfg=10                    cterm=bold
hi  Type                ctermfg=130                   cterm=bold
hi  Identifier          ctermfg=202                   cterm=bold
hi  Title               ctermfg=120                   cterm=bold
hi  htmlH2              ctermfg=130                   cterm=bold
hi  htmlH3              ctermfg=140                   cterm=bold
hi  htmlH4              ctermfg=150                   cterm=bold
hi  NonText             ctermfg=1
hi  htmlItalic                                        cterm=underline
hi  htmlBold            ctermfg=NONE    ctermbg=NONE  cterm=bold
hi  htmlBoldItalic                                    cterm=bold,underline
hi  htmlTagName         ctermfg=130                   cterm=bold
hi  PreProc             ctermfg=11                    cterm=bold
hi  Tags                ctermfg=14
hi  SpellBad            ctermfg=1       ctermbg=NONE  cterm=underline
hi  SpellReview         ctermfg=11      ctermbg=NONE  cterm=underline
hi  User1               ctermfg=12                    cterm=inverse,bold
hi  User2               ctermfg=14                    cterm=inverse,bold
hi  DiffAdd                             ctermbg=29
hi  DiffChange                          ctermbg=52
hi  DiffDelete                          ctermbg=64
hi  DiffText                            ctermbg=88    cterm=bold
hi  Error               ctermfg=21      ctermbg=9     cterm=bold
hi  StatusLineTerm      ctermfg=7       ctermbg=16    cterm=reverse

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
hi link StatusLineTermNC        StatusLineTerm
