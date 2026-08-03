# Create Git Tag Action
This GitHub Action creates a new git tag in the repository. It requires the name of the new tag to be provided as an input.

## Inputs

| Name    | Description                       | Required | Default |
|---------|-----------------------------------|----------|---------|
| tag     | Name of the new git tag to create | Yes      |         |
| message | Tag message                       | No       |         |

## Example Usage

```yaml
jobs:
  create-tag:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
        
      - name: Create new git tag
        uses: Archbot/reusables-actions/.github/actions/create-git-tag@main
        with:
          tag: v1.0.0
          message: "Release version 1.0.0"
```

> [!Warning]
> The action will fail if the tag already exists or if there are any issues with the git configuration
