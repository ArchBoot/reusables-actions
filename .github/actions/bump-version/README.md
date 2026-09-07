# Bump Version Action

Bump version in project used by the repository

## Inputs

| Input	           | Description                                |
|------------------|--------------------------------------------|
| current_version	 | The current version of the project         |
| bump_type	       | The type of bump to perform                |
| snapshot	        | Whether to append -SNAPSHOT to the version |

## Outputs

| Output	       | Description                     |
|---------------|---------------------------------|
| next_version	 | The next version of the project |

## Example Usage

```yaml
jobs:
  bump-version:
    runs-on: ubuntu-latest
        steps:
            - uses: actions/checkout@v5
    
            - name: Bump Version
                id: bump-version
                uses: Archbot/reusables-actions/.github/actions/bump-version@main
                with:
                    current_version: 1.0.0
                    bump_type: minor
                    snapshot: true
    
            - name: Print result
                run: |
                  echo "Next version: ${{ steps.bump-version.outputs.next_version }}"