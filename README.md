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