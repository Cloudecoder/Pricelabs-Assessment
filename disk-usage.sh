#!/bin/bash

set -e
# user defined dir to monitor
dtm=("/var/log" "/home")
# Set the log file path
log_file="/var/log/disk_monitor.log"
#Threshold for disk usage (in percentage)
td=80
# function fn_a to archive and remove old log files
fn_a() {
local dir=$1
# Find log files older than 30 days in the specified directory
local ol=$(find "$dir" -name "*.log" -mtime +30) &>> $log_file
# If there are old log files, create a tar archive and remove them
if [ -n "$ol" ]; then
    tar czf $dir/logs_$(date +'%Y%m%d').tar.gz $ol &>> $log_file
    rm $ol	&>> $log_file
fi
}
# Loop through each directory in the array dtm
for dir in "${dtm[@]}"; do
    # Get the filesystem associated with the directory
    fs=$(df $dir | tail -1 | awk '{print $1}')
    # Get the disk usage percentage for above filesystem
    ug=$(df $fs | tail -1 | awk '{print $5}' | sed 's/%//')
# If disk usage exceeds the threshold 80, then call the fn_a function to archive and remove old log files
if [ $ug -gt $td ]; then
    fn_a $dir &>> $log_file
fi
done
