set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "Mine"
hi Normal       ctermfg=darkgreen ctermbg=black
hi NonText      ctermfg=brown
hi comment      ctermfg=darkmagenta
hi constant     ctermfg=darkred
hi identifier   ctermfg=gray
hi statement    ctermfg=green
hi preproc      ctermfg=cyan
hi type         ctermfg=darkcyan
hi special      ctermfg=yellow
hi ErrorMsg     ctermfg=Black ctermbg=Red
hi WarningMsg   ctermfg=Black ctermbg=darkyellow
hi Error        ctermbg=Red
hi Todo         ctermfg=Black ctermbg=magenta
hi Cursor       ctermbg=lightblue ctermfg=magenta
hi MatchParen   ctermbg=brown ctermfg=magenta
hi Search       ctermbg=cyan
hi IncSearch    ctermbg=white
hi LineNr       ctermfg=darkgrey
hi title        ctermfg=darkgrey
hi StatusLineNC ctermfg=darkgrey ctermbg=darkgreen
hi StatusLine   ctermfg=darkgrey ctermbg=darkgreen
hi VertSplit    ctermfg=darkgrey guibg=darkgreen
hi label        ctermfg=blue
hi operator     ctermfg=darkyellow
hi clear Visual
hi Visual       term=reverse cterm=reverse
hi DiffChange   ctermbg=brown
hi DiffText     ctermfg=green
hi DiffAdd      ctermbg=darkcyan
hi DiffDelete   ctermbg=darkred
hi Folded       ctermbg=magenta ctermfg=black
hi FoldColumn   ctermbg=magenta ctermfg=black
hi cIf0         ctermfg=gray
hi ExtraWS      ctermbg=red guibg=red
