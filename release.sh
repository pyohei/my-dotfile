#!/bin/bash
# ----------------------------------------------------------------------
# Release vims setting script.
#
# Version: 0.0.0
# Author: Shohei Mukai
# Licence: MIT Licence
# ----------------------------------------------------------------------

VIM_BASE_DIR=${HOME}
VIM_BACKUP_DIR=${HOME}/.vim-backup

CUR_DIR=$(cd $(dirname $0);pwd)

NOW=`date +"%Y%m%d%H%M%S"`

# TODO
#   Delete cache file existing in .vim/var directory.
#   Delete dein directory .vim/dein

echo "Start --->>>"
# --- Create backup directory ---
# TODO
#   Create `backup swap undo` directory in .vim/var
#   Create dein directory
#   Or create empty directory in this repository.
if [ ! -d ${VIM_BACKUP_DIR} ]; then
    mkdir -p ${VIM_BACKUP_DIR}
fi

# TODO
#   Rotate backup. I am thinking number of max backup is 10.
backup() {
    ORG_FILE=${VIM_BASE_DIR}/.$1
    BACKUP_FILE=${VIM_BACKUP_DIR}/$1-${NOW}
    if [ -e ${ORG_FILE} ]; then
        cp -r ${ORG_FILE} ${BACKUP_FILE}
    fi
    echo ">>> backup .$1 to ${BACKUP_FILE} >>>"
}

backup vimrc
backup gvimrc

renew() {
    CUR_FILE=${CUR_DIR}/$1
    NEW_FILE=${VIM_BASE_DIR}/.$1
    cp -r ${CUR_FILE} ${NEW_FILE} 
    echo ">>> Renew .$1 >>>"
}

renew vimrc
renew gvimrc
renew vim

read -p 'Reset cnf file?[Y]: ' ANSWER
if [ "$ANSWER" = "Y" ]; then
    renew vimrc.cnf
fi

echo ">>>--- Finish"
