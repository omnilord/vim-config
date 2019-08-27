#!/bin/bash

# use BASH_CONFIG_FILE=~/.bash_profile bash ./install
BASH_CONFIG_FILE="${BASH_CONFIG_FILE:=~/.bashrc}"

mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo -e "\nexport VIMINIT='source \$MYVIMRC'" >> $BASH_CONFIG_FILE
echo "export MYVIMRC='~/.vim/.vimrc'" >> $BASH_CONFIG_FILE

vim -u NONE -c "Helptags" -c q
