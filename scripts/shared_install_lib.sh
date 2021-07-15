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

BASHDOTS=$SHARED/bash
ZSHDOTS=$SHARED/zsh
ALACRITTYDOTS=$SHARED/alacritty

installPackages(){
    echo ****INSTALLING PACKAGES****
    ## ppa packages
    sudo add-apt-repository ppa:mmstick76/alacritty
    sudo apt-get update
    sudo apt install alacritty

    ## standard packages
    sudo apt install \
         zsh \
         emacs \
         neovim \
         ripgrep
}

linkSharedDots(){
    echo ****INSTALLING SHARED DOTS****
    ln -s $BASHDOTS/.inputrc ~/.inputrc || true
    ln -s $BASHDOTS/.bash_aliases ~/.bash_aliases || true
    ln -s $SHARED/git/.gitconfig ~/.gitconfig || true
    ln -s $SHARED/spacemacs/.spacemacs ~/.spacemacs || true
    ln -s $ZSHDOTS/.zshrc ~/.zshrc || true
    ln -s $ZSHDOTS/.zshenv ~/.zshenv || true
    ln -s $ZSHDOTS/.p10k.zsh ~/.p10k.zsh || true
    ln -s $ALACRITTYDOTS/.alacritty.yml ~/.alacritty.yml || true
}

installBinaries() {
    echo ****INSTALLING BINARIES****
    # st with transparency
    #sudo cp $BINS/st /usr/local/bin/st
    #Have to configure st.info
    #tic -sx $BINS/st.info

}

installScripts() {
    echo ****INSTALLING SCRIPTS****
    # safe dd wrapper
    #sudo cp $BINS/dd /usr/local/sbin/dd

    # install z.sh if it doesn't exist
    # if ! grep -q /z/z.sh ~/.bashrc; then
    #     echo "#z.sh script" >> ~/.bashrc
    #     echo . $BINS/z/z.sh >> ~/.bashrc
    # fi
}

standardInstall() {
    installPackages
    linkSharedDots
    installBinaries
    installScripts
}