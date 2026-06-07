# Detect Stack Action

Detects the technology stack used by the repository.

## Detection Rules

The action analyzes the repository root and determines the stack based on the following files:

| File              | Detected Stack |
|-------------------|----------------|
| pom.xml           | java-maven     |
| package.json      | node           |
| none of the above | none           |

## Example Usage

```yaml
jobs:
  detect:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Detect stack
        id: detect
        uses: Archbot/reusables-actions/.github/actions/detect-stack@main

      - name: Print result
        run: echo "Detected stack: ${{ steps.detect.outputs.stack }}"
```

## Outputs

| Output | Description                |
|--------|----------------------------|
| stack  | Detected technology stack. |

### Possible Values

| Value      | Description                 |
|------------|-----------------------------|
| java-maven | Maven-based Java project    |
| node       | Node.js project             |
| none       | No supported stack detected |

## Example Output

```text
Detected stack: java-maven
```

## Requirements

* Detection is performed from the repository root directory.
