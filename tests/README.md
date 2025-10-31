# Tests

This directory contains tests for the utility scripts.

## Structure

```
tests/
├── bash/           # Tests for bash scripts
├── python/         # Tests for Python scripts
├── javascript/     # Tests for JavaScript scripts
└── fixtures/       # Test data and fixtures
```

## Running Tests

### Bash Scripts

Install and run bats:
```bash
# Install bats
git clone https://github.com/bats-core/bats-core.git
cd bats-core
./install.sh /usr/local

# Run tests
bats tests/bash/
```

### Python Scripts

Install and run pytest:
```bash
pip install pytest
pytest tests/python/
```

### JavaScript Scripts

Install and run Jest:
```bash
npm install
npm test
```

## Writing Tests

See the [Testing Guide](../docs/testing-guide.md) for detailed information on writing tests.

## Test Organization

- Place tests in the same category as the scripts they test
- Use descriptive test names
- Include both positive and negative test cases
- Test edge cases and error handling
- Keep tests independent and isolated
