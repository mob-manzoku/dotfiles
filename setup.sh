#!/bin/sh

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
dot_dir="dotemacs"
target_dir="$HOME/.emacs.d"

if [ -L $target_dir ]; then
    exit
fi

if [ -e $target_dir ]; then
    mv "$target_dir" $target_dir.bak	
fi 

ln -s "$script_dir/$dot_dir" "$target_dir" 
