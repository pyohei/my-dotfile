#!/bin/sh
#
# Distribute vim settig to home directory

FILE_DIR=`dirname ${0}`

for f in vimrc gvimrc
do
    cp ${FILE_DIR}/${f} ~/.${f}
done

cp -Rp ${FILE_DIR}/vim ~/.vim
