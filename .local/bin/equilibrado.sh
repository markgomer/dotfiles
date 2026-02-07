#!/usr/bin/env bash

sudo sh -c 'echo "350" > /sys/class/drm/card1/gt_min_freq_mhz; \
echo "500" > /sys/class/drm/card1/gt_max_freq_mhz; \
echo "600" > /sys/class/drm/card1/gt_boost_freq_mhz;'

sudo cpupower set --perf-bias 15
sudo cpupower frequency-set -g powersave -d 800MHz -u 1.8GHz

# sudo intel-undervolt apply
