# Pricelabs-Assessment

##1. What is happening in this script here?
###Ans: This script monitors disk usage in these specified directories "/var/log" "/home", and if the disk usage exceeds the threshold of 80% then tar will creates archive for 30+ days old log files and removes old logs after archival. This compression will significantly reduce the disks usage.

##2. How can you ensure the stability?
###Ans: - Using set -e to make the script exit immediately if any command exits with a non-zero status. This can help catch errors early and handle errors appropriately.
- Redirects all stdout and stderr to $log_file using &>> to capture potential error messages.
Logging for important events, errors, and the script's activities to the specified $log_file.This can be useful for troubleshooting and monitoring.

##3. How can you ensure the persistency of a script like this on a machine?
###Ans: To Ensure the persistence of this script it requires to run reliably over time by scheduling it to run at specific intervals using cron jobs.
For that it requires to edit the crontab to schedule the script to run daily
```crontab -e```
### Added the following line to run the script every monday at 11 AM
```0 11 * * MON /home/ubuntu/my_script.sh```

##4. Can you identify any possible issues with this script?
###Ans: - Yes, it has identified with couple of issues which are- 
- Variable Quoting: The script doesn't have quoted variables, which can lead to issues with paths containing spaces.
- Stdout and stderr redirection missing for log_file="/var/log/disk_monitor.log": This script lacks comprehensive error handling. Commands like df, find, tar, and rm might fail, but the script does not check for errors. Adding error-checking mechanisms, such as checking the exit status of commands, would make the script more robust.
