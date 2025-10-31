# Testing Guide

This guide explains how to test utility scripts in this repository.

## Why Test?

- **Reliability**: Ensure scripts work as expected
- **Prevent Regressions**: Catch bugs when making changes
- **Documentation**: Tests serve as usage examples
- **Confidence**: Deploy scripts with confidence

## Testing Approach

### Manual Testing

For simple scripts, manual testing may be sufficient:

1. **Test Normal Operation**
   ```bash
   ./script.sh --input normal-case.txt
   ```

2. **Test Error Cases**
   ```bash
   ./script.sh --input nonexistent.txt
   ./script.sh --invalid-option
   ./script.sh  # Missing required arguments
   ```

3. **Test Edge Cases**
   ```bash
   ./script.sh --input empty-file.txt
   ./script.sh --input large-file.txt
   ./script.sh --input "file with spaces.txt"
   ```

### Automated Testing

For complex scripts or scripts that will be frequently modified, use automated testing.

## Testing Frameworks

### Bash Scripts

Use **bats** (Bash Automated Testing System):

```bash
# Install bats
git clone https://github.com/bats-core/bats-core.git
cd bats-core
./install.sh /usr/local

# Example test file: tests/test-script.bats
#!/usr/bin/env bats

@test "script runs without errors" {
    run ./scripts/bash/my-script.sh
    [ "$status" -eq 0 ]
}

@test "script shows help" {
    run ./scripts/bash/my-script.sh --help
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Usage:" ]]
}

@test "script handles missing file" {
    run ./scripts/bash/my-script.sh nonexistent.txt
    [ "$status" -ne 0 ]
}

# Run tests
bats tests/test-script.bats
```

### Python Scripts

Use **pytest**:

```bash
# Install pytest
pip install pytest

# Example test file: tests/test_script.py
import pytest
from scripts.python import my_script

def test_basic_functionality():
    result = my_script.process_data("test")
    assert result == "expected"

def test_error_handling():
    with pytest.raises(ValueError):
        my_script.process_data(None)

def test_command_line():
    import subprocess
    result = subprocess.run(
        ['python3', 'scripts/python/my-script.py', '--help'],
        capture_output=True
    )
    assert result.returncode == 0
    assert b'Usage:' in result.stdout

# Run tests
pytest tests/
```

### JavaScript Scripts

Use **Jest**:

```bash
# Install Jest
npm install --save-dev jest

# Example test file: tests/script.test.js
const { processData, validateInput } = require('../scripts/javascript/my-script.js');

describe('processData', () => {
    test('processes data correctly', () => {
        const result = processData('test');
        expect(result).toBe('expected');
    });
    
    test('handles errors', () => {
        expect(() => {
            processData(null);
        }).toThrow();
    });
});

describe('validateInput', () => {
    test('validates correct input', () => {
        expect(validateInput('valid')).toBe(true);
    });
    
    test('rejects invalid input', () => {
        expect(validateInput('')).toBe(false);
    });
});

# Run tests
npm test
```

## Test Organization

### Directory Structure

```
tests/
├── bash/
│   ├── test-script1.bats
│   └── test-script2.bats
├── python/
│   ├── test_script1.py
│   └── test_script2.py
├── javascript/
│   ├── script1.test.js
│   └── script2.test.js
└── fixtures/
    ├── sample-data.txt
    └── test-config.json
```

### Test Data

- Store test data in `tests/fixtures/`
- Use realistic but safe test data
- Don't commit sensitive information
- Clean up temporary files after tests

## Testing Checklist

### Before Writing Tests

- [ ] Understand the script's purpose and expected behavior
- [ ] Identify key functionality to test
- [ ] Determine edge cases and error conditions
- [ ] Prepare test data and fixtures

### Test Cases to Include

- [ ] **Happy Path**: Script works with valid input
- [ ] **Help/Usage**: --help flag shows usage information
- [ ] **Missing Arguments**: Script handles missing required arguments
- [ ] **Invalid Arguments**: Script handles invalid options
- [ ] **Invalid Input**: Script validates and rejects bad input
- [ ] **Missing Files**: Script handles missing input files
- [ ] **Permission Errors**: Script handles permission issues
- [ ] **Empty Input**: Script handles empty files or data
- [ ] **Large Input**: Script handles large files efficiently
- [ ] **Special Characters**: Script handles special characters in filenames/data
- [ ] **Exit Codes**: Script returns appropriate exit codes

### After Writing Tests

- [ ] All tests pass
- [ ] Tests cover main functionality
- [ ] Tests cover error cases
- [ ] Tests are maintainable
- [ ] Tests run quickly
- [ ] Tests are documented

## Integration Testing

For scripts that interact with external systems:

### Mock External Dependencies

```python
# Python example with mocking
from unittest.mock import patch, Mock

@patch('requests.get')
def test_api_call(mock_get):
    mock_get.return_value = Mock(status_code=200, json=lambda: {'data': 'value'})
    result = my_script.fetch_data()
    assert result == {'data': 'value'}
```

### Use Test Environments

- Set up isolated test environments
- Use test databases or APIs
- Clean up after tests

## Continuous Integration

Example GitHub Actions workflow:

```yaml
# .github/workflows/test.yml
name: Test Scripts

on: [push, pull_request]

jobs:
  test-bash:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install bats
        run: |
          git clone https://github.com/bats-core/bats-core.git
          cd bats-core && sudo ./install.sh /usr/local
      - name: Run bash tests
        run: bats tests/bash/

  test-python:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
        with:
          python-version: '3.9'
      - name: Install dependencies
        run: pip install pytest
      - name: Run python tests
        run: pytest tests/python/

  test-javascript:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '14'
      - name: Install dependencies
        run: npm install
      - name: Run javascript tests
        run: npm test
```

## Best Practices

1. **Test Early**: Write tests as you develop scripts
2. **Keep Tests Simple**: Tests should be easy to understand
3. **Test One Thing**: Each test should verify one specific behavior
4. **Use Descriptive Names**: Test names should explain what they test
5. **Make Tests Independent**: Tests shouldn't depend on each other
6. **Clean Up**: Remove temporary files and reset state
7. **Fast Tests**: Keep tests fast to encourage frequent running
8. **Document Test Requirements**: Specify any special setup needed

## Debugging Failed Tests

1. **Read Error Messages**: They often point directly to the problem
2. **Run Single Test**: Isolate the failing test
3. **Add Debug Output**: Use echo/print to see what's happening
4. **Check Test Data**: Verify fixtures and test inputs
5. **Run Manually**: Execute the script manually with test inputs
6. **Check Environment**: Ensure dependencies are installed

## Example Test Suite

```bash
# tests/example.bats
#!/usr/bin/env bats

setup() {
    # Run before each test
    export TEST_DIR="$(mktemp -d)"
    export TEST_FILE="$TEST_DIR/test.txt"
    echo "test data" > "$TEST_FILE"
}

teardown() {
    # Run after each test
    rm -rf "$TEST_DIR"
}

@test "script processes file successfully" {
    run ./scripts/bash/process-file.sh "$TEST_FILE"
    [ "$status" -eq 0 ]
    [ -f "$TEST_DIR/output.txt" ]
}

@test "script validates input file" {
    run ./scripts/bash/process-file.sh nonexistent.txt
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error: File does not exist" ]]
}
```

## Resources

- [Bats Documentation](https://bats-core.readthedocs.io/)
- [Pytest Documentation](https://docs.pytest.org/)
- [Jest Documentation](https://jestjs.io/)
- [Testing Best Practices](https://github.com/goldbergyoni/javascript-testing-best-practices)
