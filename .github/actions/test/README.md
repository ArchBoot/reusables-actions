# Test Action
This GitHub Action runs tests for the project using the detected technology stack. It requires the stack information to be provided as an input, which can be obtained from the `detect-stack` action.

## Inputs

| Name  | Description                             | Required | Default |
|-------|-----------------------------------------|----------|---------|
| stack | Technology stack used by the repository | Yes      |         |

## Example Usage

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - name: Detect stack
        id: detect
        uses: Archbot/reusables-actions/.github/actions/detect-stack@main
      - name: Run tests
        uses: Archbot/reusables-actions/.github/actions/test@main
        with:
          stack: ${{ steps.detect.outputs.stack }}
```

> [!Warning]
> The action will fail if the stack is not part of the catalog or if the test process encounters any errors. Ensure that the stack is correctly detected and supported before running this action.
