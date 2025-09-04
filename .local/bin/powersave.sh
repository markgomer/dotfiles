#!/usr/bin/env bash
sudo sh -c 'echo 1 > /sys/devices/system/cpu/cpu4/online; \
echo 1 > /sys/devices/system/cpu/cpu5/online; \
echo 1 > /sys/devices/system/cpu/cpu6/online; \
echo 1 > /sys/devices/system/cpu/cpu7/online;'

sudo cpupower set --perf-bias 15
sudo cpupower frequency-set -g powersave -d 800MHz -u 1100MHz

sudo sh -c 'echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo; \
echo 0 > /sys/devices/system/cpu/cpu4/online; \
echo 0 > /sys/devices/system/cpu/cpu5/online; \
echo 0 > /sys/devices/system/cpu/cpu6/online; \
echo 0 > /sys/devices/system/cpu/cpu7/online; \
echo "350" > /sys/class/drm/card2/gt_min_freq_mhz; \
echo "550" > /sys/class/drm/card2/gt_max_freq_mhz; \
echo "600" > /sys/class/drm/card2/gt_boost_freq_mhz;'

sudo intel-undervolt apply
