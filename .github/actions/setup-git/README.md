# Setup Git Action
This GitHub Action sets up Git configuration for the repository. It allows you to specify the username and email for Git commits, as well as the default branch name.

## Inputs

| Name             | Description                          | Required | Default                                       |
|------------------|--------------------------------------|----------|-----------------------------------------------|
| `git_user_name`  | The username to use for Git commits. | false    | github-actions\[bot]                          |
| `git_user_email` | The email to use for Git commits.    | false    | github-actions\[bot]@users.noreply.github.com |

## Example Usage

```yaml
jobs:
  setup-git:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - name: Setup Git
        uses: Archbot/reusables-actions/.github/actions/setup-git@main
        with:
          git_user_name: "Your Name"
          git_user_email: "your.email@example.com"
```
