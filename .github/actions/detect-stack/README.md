# Detect Stack Action

Detects the technology stack used by the repository.

## Detection Rules

The action analyzes the repository root and determines the stack based on the following files:

| File              | Detected Stack |
|-------------------|----------------|
| pom.xml           | java-maven     |
| package.json      | node-npm       |
| none of the above | none           |

## Example Usage

```yaml
jobs:
  detect:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v5

      - name: Detect stack
        id: detect
        uses: Archbot/reusables-actions/.github/actions/detect-stack@main

      - name: Print result
        run: echo "Detected stack: ${{ steps.detect.outputs.stack }}, with version: ${{ steps.detect.outputs.stack_version }}"
```

## Outputs

| Output        | Description                |
|---------------|----------------------------|
| stack         | Detected technology stack. |
| stack-version | Detected version stack.    |

### Possible Values

| Value - `stack` | Description                 |
|-----------------|-----------------------------|
| java-maven      | Maven-based Java project    |
| node-npm        | Node.js project             |
| none            | No supported stack detected |

## Example Output

```text
Detected stack: java-maven, with version 21
```

## Requirements

* Detection is performed from the repository root directory.
