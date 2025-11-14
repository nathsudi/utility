# Bash Scripts

This directory contains Bash shell scripts for various Unix/Linux tasks.

## Usage

Make scripts executable before running:
```bash
chmod +x script-name.sh
./script-name.sh
```

## Available Scripts

### get-kubeconfig.sh
Fetches kubeconfig from orchestration platform API.

**Requirements:**
- `jq` - JSON processor
- `curl` - HTTP client
- Environment variables: `CLUSTER_FQDN`, `PROJECT_NAME`, `CLUSTER_NAME`, `USERNAME`, `PASSWORD`

**Usage:**
```bash
# Source the common config file first
source ../config.env
./get-kubeconfig.sh

# Or view help
./get-kubeconfig.sh --help
```

### dl-certs.sh
Downloads certificates from Tinkerbell nginx server.

**Requirements:**
- `wget` - File downloader
- Environment variable: `CLUSTER_FQDN`

**Usage:**
```bash
# Source the common config file first
source ../config.env
./dl-certs.sh

# Or view help
./dl-certs.sh --help
```

### clean_docker_logs.sh
Cleans Docker container logs.

**Usage:**
```bash
./clean_docker_logs.sh
```

## Configuration

All bash scripts use a common configuration file located at `../config.env` (relative to this directory).

**Setup:**
1. Edit the configuration file: `scripts/config.env`
2. Update the values with your actual configuration
3. Source the config file before running scripts:
   ```bash
   source scripts/config.env
   ./scripts/bash/<script-name>.sh
   ```

**Configuration variables:**
- `CLUSTER_FQDN` - Cluster FQDN
- `PROJECT_NAME` - Project name
- `CLUSTER_NAME` - Cluster name
- `USERNAME` - Your username
- `PASSWORD` - Your password

<!-- Add your bash scripts here with descriptions -->

## Requirements

- Bash 4.0 or higher
- Unix/Linux operating system

## Guidelines

- Use `#!/bin/bash` shebang
- Include error handling with `set -e`
- Add usage instructions in comments
- Follow bash best practices
