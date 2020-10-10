#!/bin/sh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
if [ $? -ne 0 ]; then
    exit 1
fi

cargo install exa
if [ $? -ne 0 ]; then
    exit 1
fi

cargo install fd-find
if [ $? -ne 0 ]; then
    exit 1
fi

cargo install ripgrep
if [ $? -ne 0 ]; then
    exit 1
fi

cargo install bat
if [ $? -ne 0 ]; then
    exit 1
fi

cargo install starship
if [ $? -ne 0 ]; then
    exit 1
fi

