" Vim color file
" Maintainer:	Bohdan Vlasyuk <bohdan@vstu.edu.ua>
" Last Change:	2008 Jul 18

" darkblue_custom -- for those who prefer dark background
" [note: looks bit uglier with come terminal palettes,
" but is fine on default linux console palette.]

set bg=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "darkblue_custom"

hi Normal		guifg=#fffafa guibg=black ctermfg=249 ctermbg=232
hi ErrorMsg		guifg=#ffffff guibg=#287eff			ctermfg=white ctermbg=lightblue
hi Visual		guifg=#8080ff guibg=fg		gui=reverse				ctermfg=lightblue ctermbg=fg cterm=reverse
hi VisualNOS	guifg=#8080ff guibg=fg		gui=reverse,underline	ctermfg=lightblue ctermbg=fg cterm=reverse,underline
hi Todo			guifg=#d14a14 guibg=#1248d1						ctermfg=red	ctermbg=darkblue
hi Search		guifg=#90fff0 guibg=#2050d0						ctermfg=white ctermbg=darkblue cterm=underline term=underline
hi IncSearch	guifg=#b0ffff guibg=#2050d0							ctermfg=darkblue ctermbg=gray

hi LineNr ctermbg=234 ctermfg=cyan

hi SpecialKey		guifg=cyan			ctermfg=darkcyan
hi Directory		guifg=cyan			ctermfg=cyan
hi Title			guifg=magenta gui=none ctermfg=magenta cterm=bold
hi WarningMsg		guifg=red			ctermfg=red
hi WildMenu			guifg=yellow guibg=black ctermfg=yellow ctermbg=black cterm=none term=none
hi ModeMsg			guifg=#22cce2		ctermfg=lightblue
hi MoreMsg			ctermfg=darkgreen	ctermfg=darkgreen
hi Question			guifg=green gui=none ctermfg=green cterm=none
hi NonText			guifg=#0030ff		ctermfg=darkblue

hi StatusLine	guifg=blue guibg=darkgray gui=none		ctermfg=blue ctermbg=blue term=none cterm=none
hi StatusLineNC	guifg=black guibg=darkgray gui=none		ctermfg=black ctermbg=gray term=none cterm=none
hi VertSplit	guifg=black guibg=darkgray gui=none		ctermfg=black ctermbg=gray term=none cterm=none

hi Folded	guifg=#808080 guibg=#000040			ctermfg=darkgrey ctermbg=black cterm=bold term=bold
hi FoldColumn	guifg=#808080 guibg=#000040			ctermfg=darkgrey ctermbg=black cterm=bold term=bold
hi LineNr	guifg=#90f020			ctermfg=23 cterm=none

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

hi Cursor	guifg=black guibg=yellow ctermfg=black ctermbg=yellow
hi lCursor	guifg=black guibg=white ctermfg=black ctermbg=white

hi Comment	guifg=#80a0ff ctermfg=brown
hi Constant	ctermfg=201 guifg=#ffa0a0 cterm=none
hi Special	ctermfg=27 guifg=Orange cterm=none gui=none
hi Identifier	ctermfg=cyan guifg=#40ffff cterm=none
hi Statement	ctermfg=226 cterm=none guifg=#ffff60 gui=none
hi PreProc	ctermfg=magenta guifg=#ff80ff gui=none cterm=none
hi type		ctermfg=green guifg=#60ff60 gui=none cterm=none
hi Underlined	cterm=underline term=underline
hi Ignore	guifg=bg ctermfg=bg

" suggested by tigmoid, 2008 Jul 18
hi Pmenu ctermfg=0 ctermbg=233 guifg=#444444 guibg=#af0000
hi PmenuSel ctermbg=76 guifg=#c0c0c0 guibg=#2050d0
hi PmenuSbar guifg=blue guibg=darkgray
hi PmenuThumb guifg=#c0c0c0

" アイコンの色
hi NERDTreeFlags ctermfg=15

" JS・JSXのシンタックスハイライトの上書き
hi JsxOpenPunct ctermfg=27
hi JsxClosePunct ctermfg=27
hi JsxComponentName ctermfg=27
hi JsxCloseString ctermfg=27
hi JsxTagName ctermfg=226

" popupの色
hi Pmenu ctermbg=234
hi PmenuSel ctermbg=cyan
hi PmenuThumb ctermfg=darkcyan guibg=darkcyan
hi PmenuSbar ctermbg=white
