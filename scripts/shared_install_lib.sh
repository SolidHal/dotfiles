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
RESOURCES=~/dotfiles/resources
SHARED=$DOTS/shared

BASHDOTS=$SHARED/bash
ZSHDOTS=$SHARED/zsh
ALACRITTYDOTS=$SHARED/alacritty
REGOLITHDOTS=$SHARED/regolith2

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

    ## basic packages
    sudo apt install \
         git \
         curl \
         vim \
         wget

    ## standard packages
    sudo apt install \
         zsh \
         emacs \
         ripgrep \
         keepassx

    ## regolith looks
    sudo apt install \
         regolith-look-dracula

    ## syncthing
    sudo curl -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
    sudo apt-get update
    sudo apt-get install syncthing
    systemctl --user enable syncthing.service
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
    rm -rf ~/.config/alacritty
    safeLinkDir $ALACRITTYDOTS ~/.config/alacritty
    rm -rf ~/.config/regolith2
    safeLinkDir $REGOLITHDOTS ~/.config/regolith2
}

installBinaries() {
    echo ****INSTALLING BINARIES****
    # setup alacritty terminal info
    # alacritty binary is called from the i3 config
    sudo tic -xe alacritty,alacritty-direct $RESOURCES/alacritty.info

}

installScripts() {
    echo ****INSTALLING SCRIPTS****
}


installi3xrocksLaptopIndicators(){
    echo ****INSTALLING i3xrocks indicators****
    sudo apt install i3xrocks-battery
}

installxsecurelock(){
    echo ****Installing xsecurelock****
    sudo apt install xsecurelock
    # disable gnome flashback screen saver
    gsettings set org.gnome.gnome-flashback screensaver false

    ln -s $SHARED/xsecurelock/lock.desktop ~/.local/share/applications/ || true
    ln -s $SHARED/xsecurelock/suspend.desktop ~/.local/share/applications/ || true
    update-desktop-database ~/.local/share/applications
}

standardInstall() {
    installPackages
    linkSharedDots
    installBinaries
    installScripts
    removei3xrocksIndicators
    installi3xrocksIndicators
}
