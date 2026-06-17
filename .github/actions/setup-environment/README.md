# Setup Environment Action

Setup environment to used by the repository

## Example Usage
```yaml
jobs:
  setup:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v5

      - name: Setup Environment
        uses: Archbot/reusables-actions/.github/actions/setup-environment@main
```

## Inputs

| Input         | Description             |
|---------------|-------------------------|
| stack         | Technology stack to use |
| stack_version | Stack version to use    |

### Catalog `stack` values

| Stack      | Version default       |  
|------------|-----------------------|
| java-maven | <center>`21`</center> |
| node-npm   | <center>`22`</center> |
