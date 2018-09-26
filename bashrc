# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.
export EDITOR=vim
export TERM=xterm-256color

# TivaLaunchPad toolchain
TIVA_GCC=/home/den4ix/Projects/TivaLaunchPad/gcc-arm-none-eabi-4_7-2013q1/bin
TIVA_FLASH=/home/den4ix/Projects/TivaLaunchPad/lm4tools/lm4flash
PATH=$PATH:$TIVA_GCC:$TIVA_FLASH
# my apps
PATH=$PATH:/home/den4ix/Apps/bin:/home/den4ix/.luarocks/bin
# Intel icpc compiler
PATH=$PATH:/opt/intel/bin
export PATH
export VENTAROOT=/opt/poky/1.8.2/sysroots/ventana

# grep, preserve colors with pipe
alias grep="grep --color=always"
alias grer="grep -rnI"

# git
alias gits="git status"
alias gita="git add"
alias gitcm="git commit"
alias gitco="git checkout"
alias gitph="git push"
alias gitpl="git pull"
alias gitl="git log"
alias gitb="git branch"
alias gitrm="git remove"
alias gitrt="git remote"

alias ....="cd ../../.."
alias ...="cd ../.."
alias ..="cd .."

# vim
#alias vi="vi -p"
alias gvim="gvim -p"

vi() {
	local flist
	for f in $@; do
		if [ "${f##*.}" = "@" ]; then
			h="${f%.*}.h"
			cpp="${f%.*}.cpp"
			flist="$flist $h $cpp"
		else
			flist="$flist $f"
		fi
	done
	`which vi` -p $flist
}

# look only in .c and .h files
grec()
{
    optreg="^-.*"
    nr_opt=0
    path=""
    pattern=""
    options=""
    for opt in "$@"; do
        if [[ $opt =~ $optreg ]]; then
            nr_opt=$(( $nr_opt + 1 ))
            options=$options" "$opt
        elif [[ -z $pattern ]]; then
            pattern=$opt
        else
            path=$opt
        fi
    done
    nr_nonopts=$(( $# - $nr_opt ))
    if [[ $nr_nonopts -gt 2 ]]; then
        echo "Kinda: grec [options] pattern [path...]"
    elif [[ -z $path ]]; then
        path="."
    fi
    if [[ -n $options ]]; then
        options=$pattern" "$options
    else
        options=$pattern
    fi
    find "$path" -name "*.[ch]" -exec grep -Hn --color=always "$options" '{}' \;
}

# for define, enums, typedef searches
gred()
{
    if [ $# -eq 1 ]; then
        path='.'
        pattern=$1
    elif [ $# -eq 2 ]; then
        path=$2
        pattern=$1
    else
        grep $@
        return
    fi
    find $path -name "*.[ch]" -exec \
        grep -Hn --color=always \
             -e "#define\s*$pattern" \
             -e "$pattern\s*=.*,$" \
             -e "$pattern\s*,$" \
             -e "^\s*$pattern\s*$" \
             -e "typedef\s*$pattern.*" \
             '{}' \; 
}

# shortcut for find {path} -name {name}
fnd() 
{
    if [ $# -eq 1 ]; then
        path='.'
        name="$1"
    elif [ $# -eq 2 ]; then
        path="$1"
        name="$2"
    else
        find
        return
    fi
    find "$path" -name "$name"
}

# only .c and .h files
findc()
{
    find $1 -name "*.[ch]"
}

# cscope files for the kernel
############################
#LNXPATH=/home/den4ix/ldd3_work/linux-3.2.84
#    cd /    
#    find  $LNXPATH                                                                \
#    -path "$LNXPATH/arch/*" ! -path "$LNXPATH/arch/i386*" -prune -o               \
#    -path "$LNXPATH/include/asm-*" ! -path "$LNXPATH/include/asm-i386*" -prune -o \
#    -path "$LNXPATH/tmp*" -prune -o                                           \
#    -path "$LNXPATH/Documentation*" -prune -o                                 \
#    -path "$LNXPATH/scripts*" -prune -o                                       \
#    -path "$LNXPATH/drivers*" -prune -o                                       \
#        -name "*.[chxsS]" -print >/home/den4ix/.cscope/cscope.files
cscope_kernel()
{
    if [ $# -ne 1 ]; then
        echo "Just give me path to the kernel"
        exit 1
    fi 
    CSCOPE_DATA=$HOME/.cscope
    LNXPATH=`readlink -f $1`
    LNX=`basename $LNXPATH`
    TMPFILE=`mktemp`
        find  $LNXPATH                                                                \
        -path "$LNXPATH/arch/*" ! -path "$LNXPATH/arch/i386*" -prune -o               \
        -path "$LNXPATH/include/asm-*" ! -path "$LNXPATH/include/asm-i386*" -prune -o \
        -path "$LNXPATH/tmp*" -prune -o                                           \
        -path "$LNXPATH/Documentation*" -prune -o                                 \
        -path "$LNXPATH/scripts*" -prune -o                                       \
        -path "$LNXPATH/drivers*" -prune -o                                       \
            -name "*.[chxsS]" -print > $CSCOPE_DATA/$LNX.files
    cscope -bqk -f $CSCOPE_DATA/$LNX.out $CSCOPE_DATA/$LNX.files
}
#export CSCOPE_DB=$CSCOPE_DB:$HOME/.cscope/$LNX


# some bash trickery
####################
# filename=$(basename "$fullfile")
# extension="${filename##*.}"
# filename="${filename%.*}"
####################
# ${foo  <-- from variable foo
#   ##   <-- greedy front trim
#   *    <-- matches anything
#   :    <-- until the last ':'
#  }

# prepend luarocks paths, nmap NSE paths
export LUA_PATH='/usr/share/nmap/nselib/?.lua;/usr/share/nmap/scripts/?.lua;/home/den4ix/.luarocks/share/lua/5.3/?.lua;/home/den4ix/.luarocks/share/lua/5.3/?/init.lua;/usr/lib64/lua/luarocks/share/lua/5.3/?.lua;/usr/lib64/lua/luarocks/share/lua/5.3/?/init.lua;/usr/share/lua/5.3/?.lua;/usr/share/lua/5.3/?/init.lua;/usr/lib64/lua/5.3/?.lua;/usr/lib64/lua/5.3/?/init.lua;./?.lua;./?/init.lua'
export LUA_CPATH='/home/den4ix/.luarocks/lib/lua/5.3/?.so;/usr/lib64/lua/luarocks/lib/lua/5.3/?.so;/usr/lib64/lua/5.3/?.so;/usr/lib64/lua/5.3/loadall.so;./?.so'

# ROS stuff
#. /opt/ros/kinetic/setup.bash
#export YIMG=~/VentanaYocto/ventana-yocto/build/tmp/deploy/images/ventana
#export ROS_MASTER_URI=http://argon:11311/
#export ROS_IP=10.99.99.242
#export ROS_HOSTNAME=10.99.99.242
#export ROS_ROOT=/opt/ros/kinetic/share/ros
#export ROS_PACKAGE_PATH=/opt/ros/kinetic/share
#export LD_LIBRARY_PATH=/opt/ros/kinetic/lib
#export ROSLISP_PACKAGE_DIRECTORIES=
#export ROS_DISTRO=kinetic
#export PKG_CONFIG_PATH=/opt/ros/kinetic/lib/pkgconfig
#export CMAKE_PREFIX_PATH=/opt/ros/kinetic
#export ROS_ETC_DIR=/opt/ros/kinetic/etc/ros
#export PYTHONPATH=/opt/ros/kinetic/lib/python2.7/site-packages:/opt/ros/kinetic/lib64/python2.7/site-packages
#export ROSCPP_ENABLE_DEBUG=
