#!/bin/bash
# Clean Docker logs dynamically

echo "Starting Docker log cleanup..."

# Get all volume names
volumes=$(docker volume ls --format '{{.Name}}')
volume_count=$(echo "$volumes" | wc -l)

echo "Found $volume_count Docker volume(s)"

# Loop through each volume and clean logs
for volume in $volumes; do
    log_path="/var/lib/docker/volumes/${volume}/_data/log"
    echo "Checking volume: $volume"
    if sudo test -d "$log_path"; then
        echo "  -> Found logs, cleaning..."
        sudo rm -rf "$log_path"
        echo "  -> Cleaned logs for volume: $volume"
    else
        echo "  -> No log directory found"
    fi
done

echo "Docker log cleanup completed"
