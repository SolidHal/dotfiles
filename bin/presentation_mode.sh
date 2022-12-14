#!/bin/bash


if [ -z ${1+x} ]; then echo "pass one of: enable, disable"; exit 1; else echo "${1} presentation mode"; fi


# alacritty font size, opacity
if [ "$1" = "disable" ]; then
    sed -i 's/size\: 18\.0/size\: 10\.0/g' ~/.alacritty.yml
    sed -i 's/opacity\: 1\.0/opacity\: 0\.95/g' ~/.alacritty.yml

elif [ "$1" = "enable" ]; then
    sed -i 's/size\: 10\.0/size\: 18\.0/g' ~/.alacritty.yml
    sed -i 's/opacity\: 0\.95/opacity\: 1\.0/g' ~/.alacritty.yml

else
    echo "pass one of: enable, disable"
fi


