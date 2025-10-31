# Getting Started

Welcome to the Utility Scripts repository! This guide will help you get started with using and contributing to the repository.

## Prerequisites

Depending on the scripts you want to use, you may need:

- **Bash scripts**: Unix/Linux system with Bash 4.0+
- **Python scripts**: Python 3.6 or higher
- **JavaScript scripts**: Node.js 12.0 or higher

## Installation

### Clone the Repository

```bash
git clone https://github.com/nathsudi/utility.git
cd utility
```

### Explore the Structure

```bash
# List all script categories
ls scripts/

# View available bash scripts
ls scripts/bash/

# View available Python scripts
ls scripts/python/
```

## Using Scripts

### Bash Scripts

1. Navigate to the script:
   ```bash
   cd scripts/bash/
   ```

2. Make the script executable:
   ```bash
   chmod +x script-name.sh
   ```

3. Run the script:
   ```bash
   ./script-name.sh
   ```

4. For help:
   ```bash
   ./script-name.sh --help
   ```

### Python Scripts

1. Navigate to the script:
   ```bash
   cd scripts/python/
   ```

2. Install dependencies (if required):
   ```bash
   pip install -r requirements.txt
   ```

3. Run the script:
   ```bash
   python3 script-name.py
   ```

4. Or make it executable:
   ```bash
   chmod +x script-name.py
   ./script-name.py
   ```

### JavaScript/Node.js Scripts

1. Navigate to the script:
   ```bash
   cd scripts/javascript/
   ```

2. Install dependencies (if package.json exists):
   ```bash
   npm install
   ```

3. Run the script:
   ```bash
   node script-name.js
   ```

## Adding Scripts to PATH (Optional)

To run scripts from anywhere, add the scripts directory to your PATH:

```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="$PATH:/path/to/utility/scripts/bash"
export PATH="$PATH:/path/to/utility/scripts/python"
```

Then reload your shell configuration:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

## Creating Your Own Scripts

1. Choose the appropriate category under `scripts/`
2. Use a template from `examples/` directory
3. Follow the guidelines in [CONTRIBUTING.md](../CONTRIBUTING.md)
4. Test your script thoroughly
5. Update documentation

## Getting Help

- Check the README.md in each script category
- Look at example scripts in the `examples/` directory
- Read the [Best Practices](best-practices.md) guide
- Open an issue on GitHub if you need assistance

## Next Steps

- Explore available scripts in each category
- Try running example templates
- Read the [Best Practices](best-practices.md) guide
- Learn about [Testing](testing-guide.md)
- Start contributing!
