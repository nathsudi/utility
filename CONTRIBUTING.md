# Contributing to Utility Scripts

Thank you for your interest in contributing to this utility scripts repository! This document provides guidelines and instructions for contributing.

## 🤝 How to Contribute

### Reporting Issues

- Use GitHub Issues to report bugs or suggest enhancements
- Check if the issue already exists before creating a new one
- Provide clear descriptions with examples

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Test your changes**
5. **Commit with clear messages**
   ```bash
   git commit -m "Add: brief description of changes"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Open a Pull Request**

## 📝 Script Guidelines

### General Requirements

- **Documentation**: Include clear comments and usage instructions
- **Error Handling**: Handle errors gracefully
- **Testing**: Test scripts thoroughly before submission
- **Dependencies**: Clearly document all dependencies
- **Compatibility**: Specify OS/platform requirements

### Bash Scripts

```bash
#!/bin/bash
# Script Name: example.sh
# Description: Brief description of what the script does
# Author: Your Name
# Usage: ./example.sh [options]

set -e  # Exit on error
set -u  # Exit on undefined variable

# Script content here
```

### Python Scripts

```python
#!/usr/bin/env python3
"""
Script Name: example.py
Description: Brief description of what the script does
Author: Your Name
Usage: python3 example.py [options]
"""

import sys

def main():
    """Main function"""
    pass

if __name__ == "__main__":
    main()
```

### JavaScript/Node.js Scripts

```javascript
#!/usr/bin/env node
/**
 * Script Name: example.js
 * Description: Brief description of what the script does
 * Author: Your Name
 * Usage: node example.js [options]
 */

function main() {
    // Script content here
}

if (require.main === module) {
    main();
}
```

## 🏗️ Directory Structure

Place your script in the appropriate category:

- `scripts/bash/` - Bash shell scripts
- `scripts/python/` - Python utilities
- `scripts/javascript/` - JavaScript/Node.js scripts
- `scripts/automation/` - Automation workflows
- `scripts/system/` - System administration
- `scripts/network/` - Network utilities
- `scripts/data/` - Data processing
- `scripts/misc/` - Other utilities

## ✅ Checklist Before Submitting

- [ ] Script has a clear header with description and usage
- [ ] Code follows language-specific style guidelines
- [ ] All dependencies are documented
- [ ] Error handling is implemented
- [ ] Script has been tested
- [ ] README is updated if necessary
- [ ] No sensitive information (passwords, API keys) is included

## 🔒 Security

- Never commit credentials, API keys, or sensitive data
- Use environment variables or configuration files for secrets
- Add sensitive files to `.gitignore`

## 📋 Commit Message Guidelines

- Use clear and descriptive commit messages
- Start with a verb (Add, Update, Fix, Remove, etc.)
- Keep the first line under 50 characters
- Add detailed description if necessary

Examples:
- `Add: network connectivity check script`
- `Fix: error handling in data parser`
- `Update: documentation for Python scripts`

## 🎯 Code Review

All contributions go through code review:
- Be open to feedback
- Respond to review comments
- Make requested changes promptly

## 📞 Questions?

If you have questions, feel free to:
- Open an issue for discussion
- Contact the maintainers

Thank you for contributing! 🎉
