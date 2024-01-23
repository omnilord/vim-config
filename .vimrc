execute pathogen#infect()

let g:snipMate = { 'snippet_version' : 1 }

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
set re=0 " Slow (ex. Typescript) syntax highlighting fix
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

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au BufNewFile,BufRead *.pclass,*.inc,*.ctp set filetype=php
au BufNewFile,BufRead *.coffee set filetype=coffee
au BufNewFile,BufRead *.ru,Gemfile*,*.jbuilder set filetype=ruby
au BufNewFile,BufRead *.erb set filetype=eruby
au BufNewFile,BufRead *.geojson set filetype=json
au BufNewFile,BufRead *.ts set filetype=typescript
au BufNewFile,BufRead /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
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

au BufWritePre *.{sh,cpp,conf,py,php,pclass,inc,pl,pm,c,h,cpp,hpp,rs,rb,ru,Gemfile*,jbuilder,erb,html,js,css,scss,less,json,geojson,yaml,yml,coffee,csv,ts} call StripTrailingWhitespaces()

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

function! BufferTabIndex(buf)
  let buffers = tabpagebuflist(tabpagenr())
  let buffernames = map(copy(buffers), {key, val -> bufname(val)})
  return index(buffernames, a:buf)
endfunction

function! BringMyNERDTree(...)
  "
  " If NERDTree isn't already on this tab, open it
  "

  let treenr = a:0 == 0 ? '1' : a:1
  let nerd_buf = "NERD_tree_" . treenr

  if exists("g:Use_NERDTree") && !exists("t:NERDTree_was_opened")
    execute "vert sb " . nerd_buf
    vert resize 31
    setl wfw
    wincmd w
    let t:NERDTree_was_opened = 1
  endif

  let g:Use_NERDTree = (BufferTabIndex(nerd_buf) >= 0)
endfunction

function! FlipflopNERDTreeIsOpen(...)
  "
  " When opening Vim, set focus on the correct window panel
  "

  if exists("b:NERDTree")
    let g:Use_NERDTree = 1
    let t:NERDTree_was_opened = 1
    wincmd w
    if expand('%:p') != "" && filereadable(expand('%:p'))
      NERDTreeFind %
      wincmd w
    endif
  endif
endfunction

function! CloseOutIfOnlyNERDTree()
  if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()
    quit
  endif
endfunction

let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\..*\.sw.$']
autocmd VimEnter * NERDTree
autocmd VimEnter * call FlipflopNERDTreeIsOpen()
autocmd TabEnter * call BringMyNERDTree()
autocmd BufEnter * call CloseOutIfOnlyNERDTree()

" autocmd vimenter * let &shell='/bin/zsh -i'

function! RunMyScriptSimple(cmd)
  let fpath = fnameescape(expand("%:p"))
  execute ":!" . a:cmd . " " . fpath
endfunction

function! RustScriptCompile()
  let fpath = fnameescape(expand("%:p"))
  execute ":!rustc " . fpath . "&& " . fnamemodify(fpath, ":r")
endfunction

noremap :js :call RunMyScriptSimple("node")
noremap :Js :call RunMyScriptSimple("node")
noremap :py :call RunMyScriptSimple("py")
noremap :Py :call RunMyScriptSimple("py")
noremap :rb :call RunMyScriptSimple("ruby")
noremap :Rb :call RunMyScriptSimple("ruby")
noremap :brb :call RunMyScriptSimple("bundle exec ruby")
noremap :Brb :call RunMyScriptSimple("bundle exec ruby")
noremap :rc :call RunMyScriptSimple("bundle exec rubocop")
noremap :Rc :call RunMyScriptSimple("bundle exec rubocop")
noremap :rspec :call RunMyScriptSimple("bundle exec rspec")
noremap :rk :!bundle exec rake
noremap :rkt :!bundle exec rake test
noremap :bun :!bundle exec
noremap :rt :call RunMyScriptSimple("bundle exec rails test")
noremap :Rt :call RunMyScriptSimple("bundle exec rails test")
noremap :rs :call RustScriptCompile()
noremap :Rs :call RustScriptCompile()

map <F7> gg=G<C-o><C-o>
