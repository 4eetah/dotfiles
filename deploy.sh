#!/bin/sh

dot="bashrc vimrc gvimrc vim Xresources"

pushd $(dirname $0)

deploy()
{
	local x
	for x in ${dot}; do
		echo "ln -s $PWD/$x $HOME/.$x"
		ln -s $PWD/$x $HOME/.$x
	done
}

undeploy()
{
	local x
	for x in ${dot}; do
		echo "rm -f $HOME/.$x"
		rm -f $HOME/.$x
	done
}

if [ x"$1" == x"rm" ]; then
	undeploy
else
	deploy
fi

popd
