#!/bin/bash

LOG_DIR="/var/log/myapp"

# Compress logs older than 7 days (but not already .gz)
find "$LOG_DIR" -type f -name "*.log" -mtime +7 ! -name "*.gz" -exec gzip {} \;

# Delete logs older than 30 days (both .log and .gz)
find "$LOG_DIR" -type f \( -name "*.log" -o -name "*.gz" \) -mtime +30 -exec rm -f {} \;
