# Reusables Actions
Repository that will contain reusable GitHub Actions

## Available actions

| Action               | Description                                                        | Documentation Link                                              |
|----------------------|--------------------------------------------------------------------|-----------------------------------------------------------------|
| detect-stack         | Detects the technology stack used by the repository                | [Documentation](.github/actions/detect-stack/README.md)         |
| setup-environment    | Setup environment to used by the repository                        | [Documentation](.github/actions/setup-environment/README.md)    |
| get-version          | Get version from project used by the repository                    | [Documentation](.github/actions/get-version/README.md)          |
| set-version          | Set version in project used by the repository                      | [Documentation](.github/actions/set-version/README.md)          |
| bump-version         | Bump version in project used by the repository                     | [Documentation](.github/actions/bump-version/README.md)         |
| sonar-create-project | Creates a new project in SonarQube with the specified key and name | [Documentation](.github/actions/sonar-create-project/README.md) |
| sonarqube-scan       | Runs SonarQube analysis on the repository                          | [Documentation](.github/actions/sonarqube-scan/README.md)       |
| build                | Build the project using the detected stack                         | [Documentation](.github/actions/build/README.md)                |
| test                 | Test the project using the detected stack                          | [Documentation](.github/actions/test/README.md)                 |
| create-branch        | Creates a new branch in the repository                             | [Documentation](.github/actions/create-branch/README.md)        |
| create-git-tag       | Creates a new git tag in the repository                            | [Documentation](.github/actions/create-git-tag/README.md)       |
| setup-git            | Setup git configuration for the repository                         | [Documentation](.github/actions/setup-git/README.md)            |