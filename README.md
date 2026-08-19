

Readme · MD
# Server Performance Stats
 
[![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.kernel.org/)
 
A lightweight Bash script for analysing basic server performance stats. It gathers CPU, memory and disk usage, the top resource-hungry processes, and a handful of extra diagnostics—all using standard Linux tools, with nothing to install.
 
## Table of Contents
 
- [What It Is](#what-it-is)
- [Caveats and Limitations](#caveats-and-limitations)
- [Preview in Action](#preview-in-action)
- [Requirements](#requirements)
- [How to Run](#how-to-run)
- [Project Structure](#project-structure)
- [What It Reports](#what-it-reports)
  - [Core Stats](#core-stats)
  - [Stretch Goals](#stretch-goals)
- [How It Works](#how-it-works)
- [Acknowledgements](#acknowledgements)
- [License](#license)
## What It Is
 
This repository contains a single self-contained [Bash](https://www.gnu.org/software/bash/) script, `server-stats.sh`, that analyses basic server performance statistics on any Linux machine. This project was implemented according to the [roadmap.sh Server Performance Stats project guide](https://roadmap.sh/projects/server-stats).
 
When executed, the script reads directly from the [`/proc` filesystem](https://man7.org/linux/man-pages/man5/proc.5.html) and standard utilities such as [`ps`](https://man7.org/linux/man-pages/man1/ps.1.html), [`df`](https://man7.org/linux/man-pages/man1/df.1.html) and [`free`](https://man7.org/linux/man-pages/man1/free.1.html) to produce a clear, sectioned report of the server's current health.
 
## Caveats and Limitations
 
- **Point-in-Time Snapshot:** CPU usage is sampled over a 1-second window, so the report reflects the moment the script runs—not a long-term average.
- **Root for Full Detail:** Failed login attempts (`lastb`) require root privileges; without them that line is skipped gracefully.
- **Linux Only:** The script relies on the Linux `/proc` filesystem and GNU tooling, so it is not intended for macOS or BSD systems.
## Preview in Action
 
Running the script produces a sectioned report:
 
```bash
$ ./server-stats.sh
############################################################
#          STATYSTYKI WYDAJNOŚCI SERWERA                    #
#          2026-08-18 17:38:35                              #
############################################################
 
============================================================
  1. ZUŻYCIE CPU
============================================================
Całkowite zużycie CPU: 1.0%
 
============================================================
  2. ZUŻYCIE PAMIĘCI (RAM)
============================================================
Całkowita:    3997 MB
Użyta:         223 MB  (5.6%)
Wolna:        3855 MB
...
```
 
## Requirements
 
- A Linux system with [Bash](https://www.gnu.org/software/bash/) 4+ and the standard core utilities (`ps`, `df`, `free`, `awk`, `who`).
## How to Run
 
1. **Clone the repository** and navigate to the project directory:
```bash
   git clone https://github.com/your-username/server-stats.git
   cd server-stats
```
2. **Make the script executable**:
```bash
   chmod +x server-stats.sh
```
3. **Run the script**:
```bash
   ./server-stats.sh
```
 
## Project Structure
 
```text
.
├── server-stats.sh   # The performance analysis script
└── README.md         # Project documentation
```
 
## What It Reports
 
### Core Stats
 
- **Total CPU usage** — overall processor utilisation as a percentage.
- **Total memory usage** — used vs free RAM, including the used percentage.
- **Total disk usage** — used vs free disk space, including the used percentage.
- **Top 5 processes by CPU** — the five most CPU-intensive processes.
- **Top 5 processes by memory** — the five most memory-intensive processes.
### Stretch Goals
 
- **OS version** and **kernel** release.
- **Uptime** and **load average** (1, 5, 15 minutes).
- **Logged-in users** count.
- **Failed login attempts** (when run as root).
## How It Works
 
CPU usage is calculated by taking two samples of `/proc/stat` one second apart and comparing how many clock ticks the processor spent idle versus working—the most portable and accurate approach. Memory and disk figures are parsed from `free -m` and `df -h --total` with `awk`, while `ps --sort` surfaces the busiest processes. The stretch-goal section reads ready-made values from `/etc/os-release`, `/proc/loadavg` and `who`.
 
## Acknowledgements
 
- Project idea and requirements provided by [roadmap.sh DevOps Projects](https://roadmap.sh/projects/server-stats).
## License
 
Distributed under the [MIT License](LICENSE).
 
