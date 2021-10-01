#!/bin/bash

sudo sed -i 's/HandleLidSwitch=ignore/HandleLidSwitch=suspend/g' /etc/systemd/logind.conf
