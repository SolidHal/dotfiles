#!/bin/bash

emacs --daemon
rm -f ~/.emacs-display.tmp
echo $DISPLAY >> ~/.emacs-display.tmp