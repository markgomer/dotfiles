#!/bin/bash
sudo cpupower frequency-set -g performance
sudo cpupower set --perf-bias 0
sudo cpupower frequency-set -d 800MHz -u 3.8GHz
