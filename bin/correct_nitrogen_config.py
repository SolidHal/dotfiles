#!/usr/bin/env python3

import subprocess
import pathlib

nitrogen_config = pathlib.Path.home() / (".config/nitrogen/bg-saved.cfg")
print(nitrogen_config)
res = subprocess.run(["xrandr", "--listmonitors"], check=True, text=True, capture_output=True)

xrandr_list = res.stdout.split("\n")


x_window_map = {}

left_monitor = "DisplayPort-0" # aka monitor_one in i3 config
center_monitor  = "DisplayPort-2" # aka monitor_two in i3 config
right_monitor  = "DisplayPort-1" # aka monitor_three in i3 config

# 0, 1, 2, etc from left to right
absolute_numbering = [left_monitor, center_monitor, right_monitor]

for line in xrandr_list:
    line = line.rstrip().lstrip()
    print(line)
    line_split = line.split(":")
    x_win = line_split[0]

    # map the physical monitors to their X Windows
    if left_monitor in line:
        x_window_map[left_monitor] = x_win

    elif center_monitor in line:
        x_window_map[center_monitor] = x_win

    elif right_monitor in line:
        x_window_map[right_monitor] = x_win

print(x_window_map)

# remap the nitrogen config X Windows so that the:
# first entry is the left monitor
# second is the center monitor
# third is the right monitor
config_out = []
with open(nitrogen_config, "r") as config:
    config_lines = config.readlines()
    xin_count = 0
    for line in config_lines:
        line = line.strip()
        if "[xin_" in line:
            abs_monitor = absolute_numbering[xin_count]
            corrected_x_win = x_window_map[abs_monitor]
            config_out.append(f"[xin_{corrected_x_win}]")
            xin_count += 1
        else:
            config_out.append(line)

with open(nitrogen_config, "w") as config:
    for line in config_out:
        config.write(line)
        config.write("\n")

subprocess.run(["nitrogen", "--restore"], check=True)




