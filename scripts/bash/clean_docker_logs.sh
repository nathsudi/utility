#!/bin/bash
# Clean Docker logs dynamically

# Get all volume names
volumes=$(docker volume ls --format '{{.Name}}')

# Loop through each volume and clean logs
for volume in $volumes; do
    log_path="/var/lib/docker/volumes/${volume}/_data/log"
    if [ -d "$log_path" ]; then
        echo "Cleaning logs for volume: $volume"
        sudo rm -rf "$log_path"
    fi
done
