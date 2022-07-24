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
REGOLITHDOTS=$DEVICE/regolith2

removei3xrocksIndicators(){
    echo ****REMOVING i3xrocks indicators****
    sudo apt remove i3xrocks-cpu-usage i3xrocks-net-traffic i3xrocks-next-workspace
}


installi3xrocksIndicators(){
    echo ****INSTALLING i3xrocks indicators****
    sudo apt install i3xrocks-rofication
}

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
    safeLinkDir $REGOLITHDOTS ~/.config/regolith2
}

installBinaries() {
    echo ****INSTALLING BINARIES****

}

installScripts() {
    echo ****INSTALLING SCRIPTS****
}


installi3xrocksLaptopIndicators(){
    echo ****INSTALLING i3xrocks indicators****
    sudo apt install i3xrocks-battery
}

standardInstall() {
    installPackages
    linkSharedDots
    installBinaries
    installScripts
    removei3xrocksIndicators
    installi3xrocksIndicators
}
