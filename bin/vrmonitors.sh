#!/bin/sh

if [ -z "$(xrandr --listactivemonitors | grep 'eDP-1~1')" ]; then
    #adding sub monitors is restricted by the mode size even if we enlarge the framebuffer

    if [ -z "$(xrandr | grep 6560x2560_60.00VR)" ]; then
        #modeline gotten from cvt 6000x2000
        xrandr --newmode "6560x2560_60.00VR"  1450.25  6560 7112 7840 9120  2560 2563 2573 2651 -hsync +vsync
    fi
    xrandr --fbmm 6560x2560
    xrandr --addmode eDP-1 6560x2560_60.00VR
    xrandr --output eDP-1 --panning 6560x2560_60.0VR --scale 1.0x1.0

    #add the sub displays
    xrandr --setmonitor eDP-1~1 2560/293x1440/196+0+0 eDP-1
    xrandr --setmonitor eDP-1~2 2560/293x1440/196+2560+0 none
    xrandr --setmonitor eDP-1~3 1440/293x2560/196+5120+0 none
    #kill transparency
    killall compton
else
    #CLEANUP
    xrandr --delmonitor eDP-1~1
    xrandr --delmonitor eDP-1~2
    xrandr --delmonitor eDP-1~3
    xrandr --output eDP-1 --mode 3000x2000 --scale 1.0x1.0
    xrandr --fb 3000x2000
fi
