#!/bin/sh

git submodule update --init --recursive
if [ $? -ne 0 ]; then
    exit 1
fi

if [ -f ~/.bash_aliases ]; then
    rm ~/.bash_aliases
fi
ln -s $PWD/.bash_aliases ~/.bash_aliases

if [ -f ~/.bashrc ]; then
    rm ~/.bashrc
fi
ln -s $PWD/.bashrc ~/.bashrc

if [ -f ~/.gitconfig ]; then
    rm ~/.gitconfig
fi
ln -s $PWD/.gitconfig ~/.gitconfig

if [ -f ~/.vimrc ]; then
    rm ~/.vimrc
fi
ln -s $PWD/.vimrc ~/.vimrc

if [ -d ~/.vim ]; then
    rm -rf ~/.vim
else if [ -f ~/.vim ]; then
        rm ~/.vim
     fi
fi
ln -s $PWD/.vim ~/.vim
