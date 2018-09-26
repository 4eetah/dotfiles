#!/bin/sh

dot="bashrc vimrc gvimrc vim Xresources"
for x in ${dot}; do
	echo "ln -s $PWD/$x $HOME/.$x"
	ln -s $PWD/$x $HOME/.$x
done
