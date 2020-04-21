#!/bin/bash

#Usage: TryLinkDir source_path destination_path
safeLinkDir(){
    if [ ! -d $2 ]; then
        ln -s $1 $2
    else
        echo "safeLinkDir: $2 already exists, not created"
    fi
}

DOTS=~/dotfiles/dotfiles
SHARED=$DOTS/shared
DEVICE=$DOTS/desktop

BASHDOTS=$SHARED/bash
REGOLITHDOTS=$DEVICE/regolith
#for laptop
# DEVICE=$DOTS/laptop


#shared dots
ln -s $BASHDOTS/.inputrc ~/.inputrc || true
ln -s $BASHDOTS/.bash_aliases ~/.bash_aliases || true
ln -s $SHARED/git/.gitconfig ~/.gitconfig || true
ln -s $SHARED/spacemacs/.spacemacs ~/.spacemacs || true

#device specific dots
#regolith
safeLinkDir $REGOLITHDOTS ~/.config/regolith

# install programs
sudo cp $BINS/st /usr/local/bin/st
