#!/bin/sh

# ----------------------------------------------------------------------
# Release vims setting script.
#
# Version: 0.0.0
# Author: Shohei Mukai
# Licence: MIT Licence
# ----------------------------------------------------------------------

VIM_BASE_DIR=${HOME}
VIMRC=vimrc
GVIMRC=gvimrc
VIMRC_CNF=vimrc.cnf


CUR_DIR=$(cd $(dirname $0);pwd)

# Copy Vimrc 

# Copy Gvimrc 

# Copy Vimrc configration
# If vimrc.cnf doesn't exist on home dir, copy file.
# If it has, doesn't copy.
