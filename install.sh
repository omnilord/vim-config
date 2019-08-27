#!/bin/bash

# use BASH_CONFIG_FILE=~/.bash_profile bash ./install
BASH_CONFIG_FILE="${BASH_CONFIG_FILE:=~/.bashrc}"

mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
git clone git://github.com/tpope/vim-rails.git
git clone git://github.com/vim-ruby/vim-ruby.git
git clone git://github.com/tomtom/tlib_vim.git
git clone git://github.com/MarcWeber/vim-addon-mw-utils.git
git clone git://github.com/garbas/vim-snipmate.git
git clone git://github.com/honza/vim-snippets.git
git clone git://github.com/tpope/vim-endwise.git
git clone git://github.com/scrooloose/nerdtree.git
git clone git://github.com/Xuyuanp/nerdtree-git-plugin.git
git clone git://github.com/ekalinin/Dockerfile.vim.git

echo -e "\nexport VIMINIT='source \$MYVIMRC'" >> $BASH_CONFIG_FILE
echo "export MYVIMRC='~/.vim/.vimrc'" >> $BASH_CONFIG_FILE

vim -u NONE -c "helptags nerdtree/doc" -c q
vim -u NONE -c "helptags tlib_vim/doc" -c q
vim -u NONE -c "helptags vim-addon-mw-utils/doc" -c q
vim -u NONE -c "helptags vim-rails/doc" -c q
vim -u NONE -c "helptags vim-ruby/doc" -c q
vim -u NONE -c "helptags vim-snipmate/doc" -c q
