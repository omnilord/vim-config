#!/bin/bash

# use BASH_CONFIG_FILE=~/.bash_profile bash ./install
#BASH_CONFIG_FILE="${BASH_CONFIG_FILE:=~/.bashrc}"

#echo -e "\nexport VIMINIT='source \$MYVIMRC'" >> $BASH_CONFIG_FILE
#echo "export MYVIMRC='~/.vim/.vimrc'" >> $BASH_CONFIG_FILE

mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

vim -u NONE -c "helptags nerdtree/doc" -c q
vim -u NONE -c "helptags tlib_vim/doc" -c q
vim -u NONE -c "helptags vim-addon-mw-utils/doc" -c q
vim -u NONE -c "helptags vim-rails/doc" -c q
vim -u NONE -c "helptags vim-ruby/doc" -c q
vim -u NONE -c "helptags vim-snipmate/doc" -c q
