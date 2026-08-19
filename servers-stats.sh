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

read -r mem_total mem_used mem_free < <(free -m | awk 'NR==2 {print $2, $3, $4}')
mem_pct=$(awk "BEGIN {printf \"%.1f\", ($mem_used/$mem_total)*100}")

read -r disk_total disk_used disk_free disk_pct < <(df -h --total | awk '/^total/ {print $2, $3, $4, $5}'
)

ps -eo pid,user,comm,%cpu --sort=-%cpu | head -n 6
ps -eo pid,user,comm,%mem --sort=-%mem | head -n 6

os_name=$(awk -F= '/^PRETTY_NAME=/ {gsub(/"","",$2); print $2}' /etc/os-release)
echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
echo "Load average: $(cut -d'' -f1-3 /proc/loadavg)"
echo "Zalogowani: $(who | wc -l)"

