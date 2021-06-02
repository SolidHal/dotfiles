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
BINS=~/dotfiles/bin
SHARED=$DOTS/shared
DEVICE=$DOTS/desktop

BASHDOTS=$SHARED/bash
ZSHDOTS=$SHARED/zsh
ALACRITTYDOTS=$SHARED/alacritty
REGOLITHDOTS=$DEVICE/regolith
#for laptop
# DEVICE=$DOTS/laptop

#pre reqs
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt-get update
sudo apt install alacritty

#shared dots
ln -s $BASHDOTS/.inputrc ~/.inputrc || true
ln -s $BASHDOTS/.bash_aliases ~/.bash_aliases || true
ln -s $SHARED/git/.gitconfig ~/.gitconfig || true
ln -s $SHARED/spacemacs/.spacemacs ~/.spacemacs || true
ln -s $ZSHDOTS/.zshrc ~/.zshrc || true
ln -s $ZSHDOTS/.zshenv ~/.zshenv || true
ln -s $ZSHDOTS/.p10k.zsh ~/.p10k.zsh || true
ln -s $ALACRITTYDOTS/.alacritty.yml ~/.alacritty.yml || true

#device specific dots
#regolith
safeLinkDir $REGOLITHDOTS ~/.config/regolith

# install programs
sudo cp $BINS/st /usr/local/bin/st
#Have to configure st.info
tic -sx $BINS/st.info
sudo cp $BINS/dd /usr/local/sbin/dd

# install z.sh if it doesn't exist
if ! grep -q /z/z.sh ~/.bashrc; then
    echo "#z.sh script" >> ~/.bashrc
    echo . $BINS/z/z.sh >> ~/.bashrc
fi
