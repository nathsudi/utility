#!/bin/bash

# Script to download certificates from Tinkerbell nginx server

# Sample configuration file name (relative to scripts directory)
SAMPLE_CONFIG_FILE="../config.env"

# Source environment variables from /etc/environment
if [ -f /etc/environment ]; then
    set -a  # Automatically export all variables
    source /etc/environment
    set +a  # Turn off automatic export
fi

# Configuration - Read from environment variables with fallbacks
CLUSTER_FQDN="${CLUSTER_FQDN:-your-cluster.domain.com}"

# Main function
main() {
    # Check for help flag
    if [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ "$1" = "help" ]; then
        echo "Certificate Download Script"
        echo "==========================="
        echo ""
        echo "Usage: ./dl-certs.sh [--help|-h|help]"
        echo "       source ${SAMPLE_CONFIG_FILE} && ./dl-certs.sh"
        echo ""
        echo "Configuration:"
        echo "Edit ${SAMPLE_CONFIG_FILE} with your values, then source it before running this script."
        echo "Required environment variable: CLUSTER_FQDN"
        exit 0
    fi

    # Validate CLUSTER_FQDN
    if [ -z "$CLUSTER_FQDN" ] || [ "$CLUSTER_FQDN" = "your-cluster.domain.com" ]; then
        echo "Error: CLUSTER_FQDN is not set or using default value"
        echo "Tip: Edit ${SAMPLE_CONFIG_FILE} with your configuration and source it before running this script."
        exit 1
    fi

    echo "Using cluster FQDN: $CLUSTER_FQDN"
    echo "============================================================================"

    # Remove existing certificate files if they exist
    if [ -f "db.der" ]; then
        echo "Removing existing db.der..."
        rm -f db.der
    fi

    if [ -f "Full_server.crt" ]; then
        echo "Removing existing Full_server.crt..."
        rm -f Full_server.crt
    fi

    echo "Downloading certificates..."

    # Download certificates
    wget https://tinkerbell-nginx.${CLUSTER_FQDN}/tink-stack/keys/db.der --no-check-certificate --no-proxy
    wget https://tinkerbell-nginx.${CLUSTER_FQDN}/tink-stack/keys/Full_server.crt --no-check-certificate --no-proxy

    # Check if downloads were successful
    if [ $? -eq 0 ]; then
        echo "============================================================================"
        echo "Certificates downloaded successfully!"
        echo ""
        echo "Files downloaded:"
        if [ -f "db.der" ]; then
            ls -lh db.der
        else
            echo "Warning: db.der was not downloaded."
        fi
        if [ -f "Full_server.crt" ]; then
            ls -lh Full_server.crt
        else
            echo "Warning: Full_server.crt was not downloaded."
        fi
        echo ""
        echo "Tip: For easier reuse, edit ${SAMPLE_CONFIG_FILE} with your settings and source it before running this script."
    else
        echo "============================================================================"
        echo "Error: Failed to download certificates"
        exit 1
    fi
}

# Run main function
main "$@"
