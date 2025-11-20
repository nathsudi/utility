# GitHub Actions Workflows

This directory contains GitHub Actions workflows and templates for the utility scripts repository.

## 📋 Workflows

### CI/CD Workflows

#### [CI - Lint and Test](workflows/ci.yml)
**Trigger:** Push to main/develop, Pull requests, Manual
- **lint-bash**: Validates bash scripts using shellcheck
- **lint-python**: Lints Python scripts with flake8
- **lint-javascript**: Checks JavaScript syntax
- **test-scripts**: Runs available test suites (pytest, npm test)
- **validate-structure**: Ensures repository structure integrity

#### [CodeQL Security Analysis](workflows/codeql-analysis.yml)
**Trigger:** Push to main/develop, Pull requests, Weekly schedule, Manual
- Analyzes Python and JavaScript code for security vulnerabilities
- Runs security and quality queries
- Reports findings to GitHub Security tab

#### [Validate Documentation](workflows/validate-docs.yml)
**Trigger:** Push/PR with documentation changes, Manual
- Lints markdown files for consistency
- Checks for broken links in documentation
- Ensures documentation quality

### Community Management

#### [Greetings](workflows/greetings.yml)
**Trigger:** New issues and pull requests
- Welcomes first-time contributors
- Provides guidance on contribution process
- Links to relevant documentation

#### [Label PRs](workflows/labeler.yml)
**Trigger:** Pull request opened, synchronized, or reopened
- Automatically labels PRs based on changed files
- Categories: bash, python, javascript, automation, system, network, data, documentation, tests, github-actions

#### [PR Auto-assign](workflows/pr-auto-assign.yml)
**Trigger:** Pull request opened or ready for review
- Adds size labels (xs, s, m, l, xl) based on PR size
- Helps prioritize reviews

#### [Mark Stale Issues and PRs](workflows/stale.yml)
**Trigger:** Daily schedule, Manual
- Marks issues/PRs inactive for 60 days as stale
- Closes stale items after 14 additional days
- Exempts pinned, security, and help-wanted items

#### [Close Incomplete Issues](workflows/close-incomplete-issues.yml)
**Trigger:** Daily schedule, Manual
- Closes issues needing more info after 7 days without response
- Provides 3-day warning before closing

### Release Management

#### [Create Release](workflows/release.yml)
**Trigger:** Tag push (v*.*.*), Manual with version input
- Generates changelog from git commits
- Creates GitHub release with notes
- Supports manual and tag-based releases

## 🔧 Configuration Files

### [dependabot.yml](dependabot.yml)
Automated dependency updates for:
- GitHub Actions
- Python packages (pip)
- NPM packages
- Runs weekly on Mondays

### [labeler.yml](labeler.yml)
Configuration for automatic PR labeling based on file patterns.

### [markdown-link-check-config.json](markdown-link-check-config.json)
Configuration for markdown link validation:
- Ignores localhost links
- Retry settings for flaky links
- Timeout configuration

## 📝 Templates

### Pull Request Template
[PULL_REQUEST_TEMPLATE.md](PULL_REQUEST_TEMPLATE.md)
- Structured PR description format
- Checklist for contributors
- Script category selection
- Testing documentation

### Issue Templates

#### [Bug Report](ISSUE_TEMPLATE/bug_report.md)
Template for reporting bugs or issues with scripts.

#### [Feature Request](ISSUE_TEMPLATE/feature_request.md)
Template for suggesting new scripts or enhancements.

#### [Script Submission](ISSUE_TEMPLATE/script_submission.md)
Template for submitting new utility scripts.

#### [Config](ISSUE_TEMPLATE/config.yml)
Configuration for issue template chooser and community links.

## 🚀 Getting Started

### For Contributors

1. **Creating a Pull Request:**
   - The PR template will guide you through providing necessary information
   - CI workflows will automatically run when you open a PR
   - Address any linting or test failures

2. **Opening an Issue:**
   - Choose the appropriate template (Bug Report, Feature Request, or Script Submission)
   - Fill in all required sections
   - Add relevant labels if possible

### For Maintainers

1. **Managing Workflows:**
   - All workflows can be triggered manually from the Actions tab
   - Review security alerts in the Security tab
   - Configure branch protection rules based on required checks

2. **Reviewing PRs:**
   - Check CI results before reviewing
   - Verify automatic labels are correct
   - Ensure PR follows template guidelines

## 🛠️ Workflow Best Practices

1. **Keep workflows focused:** Each workflow has a specific purpose
2. **Use caching:** Dependency caching speeds up workflow runs
3. **Fail fast:** Quick feedback on issues
4. **Continue on error:** Some checks are advisory only
5. **Security first:** CodeQL and Dependabot keep dependencies secure

## 📊 Workflow Status

You can check the status of all workflows:
- Visit the [Actions tab](../../actions)
- View individual workflow runs
- Download logs for debugging

## 🔒 Security

- CodeQL runs weekly and on every PR
- Dependabot checks for vulnerable dependencies
- Secret scanning is enabled (if available)
- Branch protection recommended for main branch

## 🤝 Contributing to Workflows

To add or modify workflows:
1. Create/edit workflow files in `.github/workflows/`
2. Test locally if possible (act, nektos/act)
3. Validate YAML syntax
4. Open a PR with your changes
5. Document new workflows in this README

## 📚 Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
- [CodeQL Documentation](https://codeql.github.com/docs/)

## 🐛 Troubleshooting

### Workflow Failures

1. **Check the logs:** Click on failed job for details
2. **Verify YAML syntax:** Use yamllint or online validators
3. **Check permissions:** Ensure workflow has necessary permissions
4. **Review recent changes:** Compare with last successful run

### Common Issues

- **Shellcheck warnings:** Fix bash script issues or add exceptions
- **Python linting:** Address flake8 issues or adjust configuration
- **Failed tests:** Debug and fix test failures
- **Link check failures:** Fix broken links or update config

For additional help, open an issue or start a discussion.
