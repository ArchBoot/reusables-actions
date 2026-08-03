# Create Branch Action
This GitHub Action creates a new branch in the repository. It requires the name of the new branch to be provided as an input.

## Inputs

| Name        | Description                                                 | Required | Default |
|-------------|-------------------------------------------------------------|----------|---------|
| branch_name | Name of the new branch to create                            | Yes      |         |
| base_branch | Name of the base branch from which to create the new branch | Yes      |         |
| push        | Whether to push the new branch to the remote repository     | No       | true    |

## Example Usage

```yaml
jobs:
  create-branch:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5

      - name: Create new branch
        uses: Archbot/reusables-actions/.github/actions/create-branch@main
        with:
          branch_name: feature/new-feature
          base_branch: main
          push: true
```

