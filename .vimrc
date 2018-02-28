execute pathogen#infect()

set nomodeline

colorscheme Mine
syntax on
set mouse=a
set hlsearch
scriptencoding utf-8
set encoding=utf-8
set ruler
set backspace=indent,eol,start
filetype plugin indent on

set cindent
set cinkeys-=:
set cinkeys-=0#
set indentkeys-=:
set indentkeys-=0#
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
match ExtraWS /\(\t\+\|\s\+$\)/

vnoremap < <gv
vnoremap > >gv
noremap :Q :q
noremap :W :w
noremap :wQ :wq
noremap :WQ :wq
noremap :Wq :wq
noremap :Qa :qa
noremap :Wa :wa
noremap :wQa :wqa
noremap :WQa :wqa
noremap :Wqa :wqa
noremap :QA :qa
noremap :WA :wa
noremap :wQA :wqa
noremap :WQA :wqa
noremap :WqA :wqa

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au BufNewFile,BufRead *.pclass,*.inc,*.ctp set filetype=php
au BufNewFile,BufRead *.coffee set filetype=coffee
au BufNewFile,BufRead *.ru,Gemfile*,*.jbuilder set filetype=ruby
au BufNewFile,BufRead *.erb set filetype=eruby
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
au BufNewFile *.pl 0r ~/.vim/templates/skeleton.pl|call ReplaceTemplateNotation()
au BufNewFile *.pm 0r ~/.vim/templates/skeleton.pm|call ReplaceTemplateNotation()
au BufNewFile *.test 0r ~/.vim/templates/skeleton.test|call ReplaceTemplateNotation()
au BufNewFile *.html 0r ~/.vim/templates/skeleton.html|call ReplaceTemplateNotation()
au BufNewFile *.php,*.pclass,*.inc,*.ctp silent! 0r ~/.vim/templates/skeleton.php|call ReplaceTemplateNotation()

" autocmd FileType ruby setlocal indentkeys-=:

" Setup a very basic template system with replacement notation

function! ReplaceTemplateNotation()
  exe ":g/<+NOW+>/s/<+NOW+>/" . strftime("%c") ."/g"
  exe ":g/<+DATE+>/s/<+DATE+>/" . strftime("%Y-%m-%d") ."/g"
  exe ":g/<+USDATE+>/s/<+USDATE+>/" . strftime("%m\\/%d\\/%Y") ."/g"
  exe ":g/<+YEAR+>/s/<+YEAR+>/" . strftime("%Y") ."/g"
  exe ":g/<+MONTH+>/s/<+MONTH+>/" . strftime("%m") ."/g"
  exe ":g/<+DAY+>/s/<+DAY+>/" . strftime("%d") ."/g"
  exe ":g/<+TIME+>/s/<+TIME+>/" . strftime("%H:%M:%S") ."/g"
  exe ":g/<+USTIME+>/s/<+USTIME+>/" . strftime("%H:%M%p") ."/g"
  exe ":g/<+HOUR+>/s/<+HOUR+>/" . strftime("%H") ."/g"
  exe ":g/<+MINUTE+>/s/<+MINUTE+>/" . strftime("%M") ."/g"
  exe ":g/<+SECOND+>/s/<+SECOND+>/" . strftime("%S") ."/g"
  exe ":g/<+AMPM+>/s/<+AMPM+>/" . strftime("%p") ."/g"
" These two commands must be last to set the cursor
  exe ":g/<+CURSOR+>/s/<+CURSOR+>//"
  startinsert!
endfunction

function! StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  :%s/\s\+$//e
  call cursor(l, c)
endfunction

function! Sass(...)
  silent !clear
  let target = substitute(bufname("%"), '\.scss$', '.css', 'i')
  if a:0 == 0
    let type = "compressed"
    let target = substitute(bufname("%"), '\.scss$', '.min.css', 'i')
  elseif a:1 ==? 'e'
    let type = "expanded"
  elseif a:1 ==? "c"
    let type = "compact"
  endif
  :execute "!sass -t " . type . " " . bufname("%") . " " . target
endfunction

autocmd VimEnter * NERDTree