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
XXH=$BINS/xxh
SHARED=$DOTS/shared
DEVICE=$DOTS/laptop

BASHDOTS=$SHARED/bash
REGOLITHDOTS=$DEVICE/regolith


#shared dots
ln -s $BASHDOTS/.inputrc ~/.inputrc || true
ln -s $BASHDOTS/.bash_aliases ~/.bash_aliases || true
ln -s $SHARED/git/.gitconfig ~/.gitconfig || true
ln -s $SHARED/spacemacs/.spacemacs ~/.spacemacs || true
ls -s $SHARED/xonsh/.xonshrc ~/.xonshrc || true

#device specific dots
#regolith
safeLinkDir $REGOLITHDOTS ~/.config/regolith

# install programs
sudo cp $BINS/st /usr/local/bin/st
#Have to configure st.info
tic -sx $BINS/st.info
sudo cp $BINS/dd /usr/local/sbin/dd

#install xonsh app image
sudo pip3 install pygments prompt-toolkit setproctitle xonsh

#install xxh app image
#pxepect package conflicts between ubuntu and pypi so lets just install as user
pip3 install xxh-xxh

# required for xxh with password
sudo apt install sshpass

# required for fzf-widgets
sudo apt-get install fzf

# install xxh xonsh package
xxh +I xxh-shell-xonsh

# install xxh dotfiles package locally
xxh +I xxh-plugin-prerun-dotfiles+path+$SHARED/xxh-plugin-prerun-dotfiles

#activate xonsh as the default shell
command -v xonsh | sudo tee -a /etc/shells
chsh -s $(which xonsh)
sudo chsh -s $(which xonsh)

#TODO: add to .xonshrc when stable
$COMPLETIONS_CONFIRM=True

# install z.sh if it doesn't exist
if ! grep -q /z/z.sh ~/.bashrc; then
    echo "#z.sh script" >> ~/.bashrc
    echo . $BINS/z/z.sh >> ~/.bashrc
fi
