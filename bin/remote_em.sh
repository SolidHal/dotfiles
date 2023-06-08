#!/bin/bash

DISP=$(cat ~/.emacs-display.tmp)
emacsclient -nq $1 -d $DISP


