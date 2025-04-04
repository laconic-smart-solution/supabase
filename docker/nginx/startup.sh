#!/bin/bash
 
# Start cron (busybox) in background
crond -l 2 -b

# Start nginx
nginx

