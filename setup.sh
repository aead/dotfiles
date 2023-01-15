#!/bin/sh
if [ -f ~/.zshrc ]; then
    rm ~/.zshrc
fi
ln -s $PWD/.zshrc ~/.zshrc

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