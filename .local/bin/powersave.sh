#!/usr/bin/env bash

# sudo sh -c 'echo 1 > /sys/devices/system/cpu/cpu4/online; \
# echo 1 > /sys/devices/system/cpu/cpu5/online; \
# echo 1 > /sys/devices/system/cpu/cpu6/online; \
# echo 1 > /sys/devices/system/cpu/cpu7/online;'

sudo cpupower set --perf-bias 15
sudo cpupower frequency-set -g powersave -d 800MHz -u 1300MHz

sudo sh -c 'echo "350" > /sys/class/drm/card1/gt_min_freq_mhz; \
echo "500" > /sys/class/drm/card1/gt_max_freq_mhz; \
echo "500" > /sys/class/drm/card1/gt_boost_freq_mhz;'

# sudo intel-undervolt apply
