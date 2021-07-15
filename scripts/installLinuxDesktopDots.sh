#!/bin/bash

source shared_install_lib.sh

DEVICE=$DOTS/desktop
REGOLITHDOTS=$DEVICE/regolith

standardInstall

#device specific dots
#regolith
safeLinkDir $REGOLITHDOTS ~/.config/regolith
