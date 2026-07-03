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
    \                       guifg=#ffffff   guibg=#000000
hi  Ignore              ctermfg=7
    \                       guifg=#999999
hi  Cursor                              ctermbg=1       cterm=reverse
    \                       guifg=NONE      guibg=NONE      gui=reverse
hi  Comment             ctermfg=116
    \                       guifg=#3366ff
hi  Constant            ctermfg=12
    \                       guifg=#cc6600
hi  Keyword             ctermfg=11                      cterm=bold
    \                       guifg=#ff5050                   gui=bold
hi  PreProc             ctermfg=7
    \                       guifg=#e67300
hi  String              ctermfg=13
    \                       guifg=#b300b3
hi  htmlString          ctermfg=4                       cterm=underline
    \                       guifg=#3366ff                   gui=underline
hi  Float               ctermfg=9
    \                       guifg=#e6ac00
hi  Statement           ctermfg=10                      cterm=bold
    \                       guifg=#339933                   gui=bold
hi  Type                ctermfg=130                     cterm=bold
    \                       guifg=#b30000                   gui=bold
hi  Identifier          ctermfg=202                     cterm=bold
    \                       guifg=#cc6600                   gui=bold
hi  Title               ctermfg=120                     cterm=bold
    \                       guifg=#66cc00                   gui=bold
hi  htmlH2              ctermfg=130                     cterm=bold
    \                       guifg=#ac7339                   gui=bold
hi  htmlH3              ctermfg=140                     cterm=bold
    \                       guifg=#ac39ac                   gui=bold
hi  htmlH4              ctermfg=150                     cterm=bold
    \                       guifg=#a6d279                   gui=bold
hi  NonText             ctermfg=1
    \                       guifg=#ff00ff
hi  htmlItalic                                          cterm=underline
    \                                                       gui=underline
hi  htmlBold            ctermfg=NONE    ctermbg=NONE    cterm=bold
    \                       guifg=NONE      guibg=NONE      gui=bold
hi  htmlBoldItalic                                      cterm=bold,underline
    \                                                       gui=bold,underline
hi  htmlTagName         ctermfg=130                     cterm=bold
    \                       guifg=#b300b3                   gui=bold
hi  Tags                ctermfg=14
    \                       guifg=#0080ff
hi  SpellBad            ctermfg=1       ctermbg=NONE    cterm=underline
    \                       guifg=#ff0040   guibg=NONE      gui=underline
hi  SpellReview         ctermfg=11      ctermbg=NONE    cterm=underline
    \                       guifg=#b38f00   guibg=NONE      gui=underline
hi  User1               ctermfg=12                      cterm=inverse,bold
    \                       guifg=#00b3b3                   gui=inverse,bold
hi  User2               ctermfg=14                      cterm=inverse,bold
    \                       guifg=#b3b300                   gui=inverse,bold
hi  DiffAdd                             ctermbg=29
    \                                       guibg=#80ffbf
hi  DiffChange                          ctermbg=52
    \                                       guibg=#ffdf80
hi  DiffDelete                          ctermbg=64
    \                                       guibg=#ff8080
hi  DiffText                            ctermbg=88      cterm=bold
    \                                       guibg=#99ccff   gui=bold
hi  Error               ctermfg=21      ctermbg=9       cterm=bold
    \                       guifg=#b3b300   guibg=#000000   gui=bold,reverse
hi  StatusLineTerm      ctermfg=7       ctermbg=16      cterm=reverse
    \                       guifg=#000000   guibg=#ffffff   gui=reverse

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
