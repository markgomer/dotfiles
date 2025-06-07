#!/usr/bin/env bash
sudo sh -c 'echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo; \
echo 1 > /sys/devices/system/cpu/cpu4/online; \
echo 1 > /sys/devices/system/cpu/cpu5/online; \
echo 1 > /sys/devices/system/cpu/cpu6/online; \
echo 1 > /sys/devices/system/cpu/cpu7/online; \
echo "1100" > /sys/class/drm/card1/gt_max_freq_mhz; \
echo "1100" > /sys/class/drm/card1/gt_boost_freq_mhz'
sudo cpupower set --perf-bias 15
sudo cpupower frequency-set -g powersave -d 800MHz -u 2.4GHz
