#!/bin/bash

#podstawowe statystyki wydajności serwera Linux

set -uo pipefail

print_header() {
echo
echo ".........................................."
echo " $1"
echo ".........................................."
}

read_cpu() {
read -r _ user nice system idle iowait irq softirq steal _ _ < /proc/stat
local idle_all=$((idle + iowait))
local non_idle=$((user + nice + system + irq + softirq + steal))
local total = $((idle_all + non_idle))
echo "$total $idle_all"
}

read total1 idle1 <<< "$(read_cpu)"
sleep 1
read total2 idle2 <<< "$(read_cpu)"

total_diff=$((total2 - total1))
idle_diff=((idle2 - idle1))
cpu_usage=$(awk "BEGIN {printf \"%.1f\", (100*($total_diff-$idle_diff))/$total_diff}")


