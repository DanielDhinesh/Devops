#!/bin/bash

get_cpu_usage(){
    echo "Cpu Usage"
    top -bn1 | grep "%Cpu(s)" | awk '{printf "User: %.2f%%, System: %.2f%%, Idle: %.2f%%\n", $2,$4,$8}'
}

get_mem_usage(){
    echo "Memory Usage"
    free --mega | awk 'NR==2 {printf "total: %s MB, used: %.2f%%, free: %s MB\n", $2, ($3/$2)*100, ($4/$2)*100}'
}

get_disk_usage(){
    echo "Disk Usage"
    df -h --total | grep "total" | awk '{printf "Size: %s, Used: %s, Available: %s\n", $2,$3,$4}'
}

get_top_processes_mem(){
    echo "Top 5 memory processes"
    ps -eo pid,comm,%mem --sort=-%mem | head -6
}

top_processes_cpu(){
    echo "Top 5 Cpu processes"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6
}

get_stretch_goals() {
    echo "************System Info and Additional Stats************"
    echo "OS Version: $(lsb_release -d | awk -F' ' '{print $2,$3}')"
    echo "Uptime: $(uptime -p)"
    echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
    echo "Logged in Users: $(who | wc -l)"
    echo "Failed Login Attempts: $(grep 'Failed password' /var/log/auth.log | wc -l)"
}

seperator(){
    echo "-------------------------------------------------"
}

echo "************Server performance stats************"

get_cpu_usage
seperator

get_mem_usage
seperator

get_disk_usage
seperator

get_top_processes_mem
seperator

top_processes_cpu
seperator

get_stretch_goals
seperator