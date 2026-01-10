#!/usr/bin/env bash

sudo sh -c 'echo "350" > /sys/class/drm/card0/gt_min_freq_mhz; \
echo "1100" > /sys/class/drm/card0/gt_max_freq_mhz; \
echo "1100" > /sys/class/drm/card0/gt_boost_freq_mhz;'

sudo cpupower set --perf-bias 15
sudo cpupower frequency-set -g performance -d 800MHz -u 3.8GHz
