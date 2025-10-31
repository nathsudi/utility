#!/bin/bash
#
# Script Name: bash-template.sh
# Description: Template for bash scripts
# Author: Your Name
# Date: YYYY-MM-DD
# Version: 1.0
# Usage: ./bash-template.sh [options]
#

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error
set -o pipefail  # Return value of a pipeline is the value of the last command to exit with a non-zero status

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

# Script directory
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#######################################
# Display usage information
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Writes usage information to stdout
#######################################
usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Description of what this script does.

OPTIONS:
    -h, --help          Show this help message
    -v, --verbose       Enable verbose output
    -d, --debug         Enable debug mode
    
EXAMPLES:
    $(basename "$0") --help
    $(basename "$0") --verbose

EOF
}

#######################################
# Log an informational message
# Arguments:
#   Message to log
#######################################
log_info() {
    echo -e "${GREEN}[INFO]${NC} $*"
}

#######################################
# Log a warning message
# Arguments:
#   Message to log
#######################################
log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*" >&2
}

#######################################
# Log an error message
# Arguments:
#   Message to log
#######################################
log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

#######################################
# Clean up function called on exit
#######################################
cleanup() {
    # Add cleanup tasks here
    log_info "Cleaning up..."
}

#######################################
# Main function
#######################################
main() {
    local verbose=false
    local debug=false
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                usage
                exit 0
                ;;
            -v|--verbose)
                verbose=true
                shift
                ;;
            -d|--debug)
                debug=true
                set -x  # Enable debug mode
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    # Register cleanup function
    trap cleanup EXIT
    
    log_info "Script started"
    
    # Your script logic here
    
    log_info "Script completed successfully"
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
