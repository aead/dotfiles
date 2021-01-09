#!/bin/sh

git submodule update --init --recursive
if [ $? -ne 0 ]; then
    exit 1
fi

if [ -f ~/.bash_aliases ]; then
    rm ~/.bash_aliases
fi
ln -s $PWD/.bash_aliases ~/.bash_aliases

if [ -f ~/.bash_tools ]; then
    rm ~/.bash_tools
fi
ln -s $PWD/.bash_tools ~/.bash_tools

if [ -f ~/.bashrc ]; then
    rm ~/.bashrc
fi
ln -s $PWD/.bashrc ~/.bashrc

if [ -f ~/.gitconfig ]; then
    rm ~/.gitconfig
fi
ln -s $PWD/.gitconfig ~/.gitconfig

if [ -f ~/.ignore ]; then
    rm ~/.ignore
fi
ln -s $PWD/.ignore ~/.ignore

if [ -f ~/.config/starship.toml ]; then
    rm ~/.config/starship.toml
fi
ln -s $PWD/starship.toml ~/.config/starship.toml

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
