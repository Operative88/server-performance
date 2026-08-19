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
