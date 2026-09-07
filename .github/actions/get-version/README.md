# Get Version Action

Get version from project used by the repository

## Example Usage

```yaml
jobs:
  get-version:
    runs-on: ubuntu-latest
    
    steps:
        - uses: actions/checkout@v5
    
        - name: Get Version
            id: get-version
            uses: Archbot/reusables-actions/.github/actions/get-version@main
    
        - name: Print result
            run: |
              echo "Detected version: ${{ steps.get-version.outputs.version }}"
              echo "Base version: ${{ steps.get-version.outputs.base_version }}"
              echo "Is Snapshot: ${{ steps.get-version.outputs.is_snapshot }}"
              echo "Major: ${{ steps.get-version.outputs.major }}"
              echo "Minor: ${{ steps.get-version.outputs.minor }}"
              echo "Patch: ${{ steps.get-version.outputs.patch }}"
```

## Inputs

| Input	 | Description             |
|--------|-------------------------|
| stack	 | Technology stack to use |

### Catalog `stack` values

| Stack        |
|--------------|
| `java-maven` |
| `node-npm`   |

## Outputs

| Output       | Description                    |
|--------------|--------------------------------|
| version      | Detected version               |
| base_version | Base version whithout snapshot |
| is_snapshot  | Indicates if it's a snapshot   |
| major        | Major version number           |
| minor        | Minor version number           |
| patch        | Patch version number           |


> [!Warning]
> The action will fail if the stack is not part of the catalog or if the version cannot be detected.