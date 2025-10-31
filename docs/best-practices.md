# Best Practices

This guide outlines best practices for writing utility scripts in this repository.

## General Principles

### 1. Code Quality

- **Write Clear Code**: Prioritize readability over cleverness
- **Use Meaningful Names**: Variables and functions should be self-explanatory
- **Keep It Simple**: Avoid unnecessary complexity
- **Follow DRY**: Don't Repeat Yourself - extract common code into functions

### 2. Documentation

- **Header Comments**: Include script name, description, author, and usage
- **Function Documentation**: Document what functions do, their parameters, and return values
- **Inline Comments**: Explain complex logic, not obvious code
- **Usage Examples**: Provide clear examples of how to use the script

### 3. Error Handling

- **Validate Input**: Check all user inputs and arguments
- **Handle Errors Gracefully**: Don't let scripts crash unexpectedly
- **Provide Helpful Messages**: Error messages should explain what went wrong
- **Exit Codes**: Use appropriate exit codes (0 for success, non-zero for errors)

### 4. Security

- **Never Commit Secrets**: Use environment variables or config files
- **Validate User Input**: Prevent injection attacks
- **Use Secure Defaults**: Fail closed, not open
- **Document Permissions**: Specify required permissions or privileges

## Language-Specific Guidelines

### Bash Scripts

```bash
#!/bin/bash
set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Catch errors in pipes

# Use local variables in functions
function my_function() {
    local var="value"
    echo "$var"
}

# Quote variables to handle spaces
echo "$my_variable"

# Use [[ ]] for conditionals (more powerful than [ ])
if [[ "$var" == "value" ]]; then
    echo "Match"
fi

# Check command success
if command -v git &> /dev/null; then
    echo "Git is installed"
fi
```

### Python Scripts

```python
#!/usr/bin/env python3
"""Module docstring explaining purpose."""

import sys
from typing import Optional

def my_function(param: str) -> Optional[str]:
    """
    Function docstring.
    
    Args:
        param: Parameter description
        
    Returns:
        Return value description
    """
    return param

# Use main() function
def main() -> int:
    """Main entry point."""
    return 0

if __name__ == "__main__":
    sys.exit(main())
```

### JavaScript/Node.js Scripts

```javascript
#!/usr/bin/env node
'use strict';

/**
 * Function description
 * @param {string} param - Parameter description
 * @returns {string} Return value description
 */
function myFunction(param) {
    return param;
}

// Use async/await for asynchronous operations
async function main() {
    try {
        // Your code here
        return 0;
    } catch (error) {
        console.error(error.message);
        return 1;
    }
}

if (require.main === module) {
    main().then(code => process.exit(code));
}
```

## Testing

### Before Committing

1. **Test Normal Cases**: Verify the script works as expected
2. **Test Edge Cases**: Empty inputs, large files, special characters
3. **Test Error Cases**: Invalid inputs, missing files, permission errors
4. **Test on Clean Environment**: Ensure no undocumented dependencies
5. **Test Different Systems**: If possible, test on different OS versions

### Automated Testing

- Add unit tests when appropriate
- Use test frameworks: pytest (Python), Jest (JavaScript), bats (Bash)
- Keep tests in the `tests/` directory

## Performance

- **Avoid Unnecessary Work**: Cache results, skip redundant operations
- **Handle Large Files Efficiently**: Stream data instead of loading all into memory
- **Provide Progress Feedback**: For long-running operations
- **Implement Timeouts**: For network operations and external commands

## Maintainability

- **Version Your Scripts**: Include version information in the header
- **Document Changes**: Update version and date when modifying scripts
- **Keep Dependencies Minimal**: Fewer dependencies = easier maintenance
- **Use Standard Libraries**: Prefer standard libraries over third-party ones

## Portability

- **Specify Requirements**: Document OS, version, and dependency requirements
- **Use Portable Code**: Avoid OS-specific features when possible
- **Test Across Platforms**: Verify scripts work on target systems
- **Handle Path Separators**: Use proper path handling functions

## User Experience

- **Provide Help**: Always include -h/--help option
- **Use Consistent Options**: Follow common conventions (-v for verbose, -q for quiet)
- **Give Feedback**: Show progress for long operations
- **Make Scripts Interactive**: Confirm destructive operations
- **Support Dry-Run**: Allow users to see what would happen without doing it

## Example: Good vs Bad

### Bad Example
```bash
# No error checking, no documentation
cp $1 $2
rm $1
```

### Good Example
```bash
#!/bin/bash
# move-file.sh - Safely move a file
# Usage: ./move-file.sh <source> <destination>

set -e

if [[ $# -ne 2 ]]; then
    echo "Error: Expected 2 arguments" >&2
    echo "Usage: $0 <source> <destination>" >&2
    exit 1
fi

source="$1"
destination="$2"

if [[ ! -f "$source" ]]; then
    echo "Error: Source file does not exist: $source" >&2
    exit 1
fi

cp "$source" "$destination"
rm "$source"

echo "Successfully moved $source to $destination"
```

## Resources

- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [PEP 8 - Python Style Guide](https://www.python.org/dev/peps/pep-0008/)
- [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
- [ShellCheck](https://www.shellcheck.net/) - Shell script linter
