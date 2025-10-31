#!/bin/bash

# Simple script to fetch kubeconfig from orchestration platform API

# Source environment variables from /etc/environment
if [ -f /etc/environment ]; then
    set -a  # Automatically export all variables
    source /etc/environment
    set +a  # Turn off automatic export
fi

# Configuration - Read from environment variables with fallbacks
CLUSTER_FQDN="${CLUSTER_FQDN:-sc-dev.espd.infra-host.com}"
PROJECT_NAME="${PROJECT_NAME:-sn}"
CLUSTER_NAME="${CLUSTER_NAME:-snc-cluster}"
USERNAME="${USERNAME:-emf-sn-user}"
PASSWORD="${PASSWORD:-ChangeMeOn1stLogin!}"

# Global variables
JWT_TOKEN=""
KUBECONFIG_FILE=""

# Function to check dependencies
check_dependencies() {
    echo "Checking dependencies..."
    
    if ! command -v jq &> /dev/null; then
        echo "Error: jq is required but not installed. Please install jq and try again."
        exit 1
    fi
    
    if ! command -v curl &> /dev/null; then
        echo "Error: curl is required but not installed. Please install curl and try again."
        exit 1
    fi
    
    echo "Dependencies check passed"
}

# Function to get JWT token from Keycloak
get_jwt_token() {
    echo "Getting JWT token..."
    
    JWT_TOKEN=$(curl -s --location --request POST "https://keycloak.${CLUSTER_FQDN}/realms/master/protocol/openid-connect/token" \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --data-urlencode 'grant_type=password' \
        --data-urlencode 'client_id=system-client' \
        --data-urlencode "username=${USERNAME}" \
        --data-urlencode "password=${PASSWORD}" \
        --data-urlencode 'scope=openid profile email groups' | jq -r .access_token)

    if [ "$JWT_TOKEN" == "null" ] || [ -z "$JWT_TOKEN" ]; then
        echo "Error: Failed to get JWT token. Check credentials and cluster FQDN."
        exit 1
    fi
    
    echo "JWT token obtained successfully"
}

# Function to save kubeconfig directly to ~/.kube/config
save_kubeconfig() {
    local kubeconfig_json=$1
    
    # Create .kube directory if it doesn't exist
    mkdir -p ~/.kube
    
    # Extract kubeconfig YAML from JSON response and save directly to ~/.kube/config
    echo "$kubeconfig_json" | jq -r '.kubeconfig' > ~/.kube/config
    
    # Set secure permissions
    chmod 600 ~/.kube/config
    
    echo "Success: Kubeconfig saved directly to ~/.kube/config"
}

# Function to setup kubectl environment
setup_kubectl() {
    echo "kubectl is now configured globally and ready to use!"
}

# Function to test kubectl connection
test_kubectl() {
    if command -v kubectl &> /dev/null; then
        echo "Testing kubectl connection..."
        kubectl cluster-info --request-timeout=5s
    else
        echo "kubectl not found. Install kubectl to test cluster connectivity."
    fi
}

# Main function
main() {
    echo "Starting kubeconfig retrieval for cluster: $CLUSTER_NAME in project: $PROJECT_NAME"
    echo "============================================================================"
    
    # Check dependencies
    check_dependencies
    
    # Get JWT token
    get_jwt_token
    
    # Fetch kubeconfig  
    echo "Fetching kubeconfig..."
    local api_url="https://api.${CLUSTER_FQDN}/v2/projects/${PROJECT_NAME}/clusters/${CLUSTER_NAME}/kubeconfigs"
    
    local response=$(curl -s -w "\n%{http_code}" \
        --location \
        --request GET "$api_url" \
        --header 'Accept: application/json' \
        --header "Authorization: Bearer $JWT_TOKEN")

    # Extract response body and status code
    local response_body=$(echo "$response" | head -n -1)
    local http_code=$(echo "$response" | tail -n 1)

    if [ "$http_code" -eq 200 ]; then
        echo "Kubeconfig retrieved successfully (HTTP $http_code)"
        
        # Save kubeconfig to file
        save_kubeconfig "$response_body"
        
        # Setup kubectl environment
        setup_kubectl
        
        # Test kubectl
        test_kubectl
    else
        echo "Error: Failed to get kubeconfig (HTTP $http_code)"
        echo "Response: $response_body"
        exit 1
    fi
    
    echo "============================================================================"
    echo "Process completed successfully!"
    echo "kubectl is now ready to use globally. You can run 'kubectl cluster-info' from any directory."
    echo "Note: For new terminal sessions, the configuration will be automatically loaded."
}

# Run main function
main "$@"
