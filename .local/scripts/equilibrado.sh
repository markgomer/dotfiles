#!/bin/bash
sudo cpupower set --perf-bias 15
sudo cpupower frequency-set -g powersave -d 800MHz -u 2.4GHz
