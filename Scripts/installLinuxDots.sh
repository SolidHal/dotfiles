#!/bin/bash

#Usage: TryLinkDir source_path destination_path
safeLinkDir(){
    if [ ! -d $2 ]; then
        ln -s $1 $2
    else
        echo "safeLinkDir: $2 already exists, not created"
    fi
}
#Bash Stuff
ln -s ~/dotfiles/linux/.inputrc ~/.inputrc

#SSHrc stuff
ln -s ~/dotfiles/linux/.sshrc ~/.sshrc
safeLinkDir ~/dotfiles/linux/.sshrc.d ~/.sshrc.d/

#spacemacs, git, i3
ln -s ~/dotfiles/linux/.spacemacs ~/.spacemacs
ln -s ~/dotfiles/linux/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/linux/i3/config ~/.config/i3/config
