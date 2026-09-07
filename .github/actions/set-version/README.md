# Set Version Action

Set version in project used by the repository

### Example Usage

```yaml
jobs:
  set-version:
    runs-on: ubuntu-latest
    steps:
        - uses: actions/checkout@v5

        - name: Set Version¿
            uses: Archbot/reusables-actions/.github/actions/set-version@main
            with:
                stack: java-maven
                version: 1.0.0

        - name: Get Version
            id: get-version
            uses: Archbot/reusables-actions/.github/actions/get-version@main
            with:
                stack: java-maven

        - name: Print result
            run: |
              echo "Set version to: ${{ steps.get-version.outputs.version }}"
```
## Inputs

| Input	  | Description             |
|---------|-------------------------|
| stack	  | Technology stack to use |
| version | Version to set          |

### Catalog `stack` values

| Stack        |
|--------------|
| `java-maven` |
| `node-npm`   |


> [!Warning]
> The action will fail if the stack is not part of the catalog