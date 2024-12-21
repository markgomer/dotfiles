#!/bin/bash
sudo cpupower frequency-set -g powersave
sudo cpupower set --perf-bias 15
sudo cpupower frequency-set -d 800MHz -u 1100MHz
