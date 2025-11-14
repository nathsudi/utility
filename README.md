# 🛠️ Utility Scripts

A curated collection of utility scripts for development and system administration tasks.

## 📁 Structure

```
utility/
├── scripts/
│   ├── config.env       # Shared configuration file
│   ├── bash/            # Bash shell scripts
│   ├── python/          # Python utilities
│   ├── automation/      # Workflow automation
│   ├── system/          # System administration
│   ├── network/         # Network tools
│   ├── data/            # Data processing
│   └── misc/            # Other utilities
├── docs/                # Documentation
├── tests/               # Test scripts
└── examples/            # Usage templates
```

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/nathsudi/utility.git
cd utility

# Configure environment variables
vim scripts/config.env

# Run a script
source scripts/config.env && ./scripts/bash/get-kubeconfig.sh
```

## � Available Scripts

### Bash Scripts

#### **get-kubeconfig.sh**
Fetch kubeconfig from orchestration platform API via Keycloak authentication.

```bash
source scripts/config.env && ./scripts/bash/get-kubeconfig.sh
```

#### **dl-certs.sh**
Download certificates from Tinkerbell nginx server.

```bash
source scripts/config.env && ./scripts/bash/dl-certs.sh
```

#### **clean_docker_logs.sh**
Clean up Docker container logs to free disk space.

```bash
./scripts/bash/clean_docker_logs.sh
```

## ⚙️ Configuration

Edit `scripts/config.env` with your values:

```bash
export CLUSTER_FQDN="your-cluster.domain.com"
export PROJECT_NAME="your-project"
export CLUSTER_NAME="your-cluster"
export USERNAME="your-username"
export PASSWORD="your-password"
```

Then source the config before running scripts:
```bash
source scripts/config.env && ./scripts/bash/<script-name>.sh
```

## 📖 Documentation

- **[Getting Started](docs/getting-started.md)** - Setup and basic usage
- **[Best Practices](docs/best-practices.md)** - Coding standards and guidelines
- **[Testing Guide](docs/testing-guide.md)** - How to test scripts
- **[GitHub Workflows](docs/github-workflows.md)** - CI/CD and automation

## 🤝 Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Adding a Script

1. Place script in appropriate category under `scripts/`
2. Add help flag support (`--help`, `-h`)
3. Use `scripts/config.env` for shared configuration
4. Include clear comments and error handling
5. Update README with script description

## � Tips

- All bash scripts support `--help` flag for usage information
- Scripts read from `scripts/config.env` or `/etc/environment`
- Use absolute paths when sourcing config from subdirectories
- Test scripts in non-production environments first

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 👤 Author

**Nath Sudi**
- GitHub: [@nathsudi](https://github.com/nathsudi)

---

⭐ **Star this repo if you find it helpful!**
