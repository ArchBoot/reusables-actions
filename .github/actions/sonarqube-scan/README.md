# SonarQube Scan Action
This GitHub Action runs SonarQube analysis on the repository. It requires a SonarQube server URL and an authentication token to perform the analysis.

## Inputs

| Name                 | Description                                            | Required | Default                |
|----------------------|--------------------------------------------------------|----------|------------------------|
| stack                | Technology stack used by the repository                | Yes      |                        |
| sonar_host_url       | URL of the SonarQube server                            | Yes      |                        |
| sonar-token          | Authentication token for the SonarQube server          | Yes      |                        |
| project-key          | Project key for the SonarQube analysis                 | Yes      |                        |
| project-name         | Project name for the SonarQube analysis                | Yes      |                        |
| branch-name          | Branch name for the SonarQube analysis                 | No       | ${{ github.ref_name }} |
| sources              | Source directory for the SonarQube analysis            | No       | src                    |
| coverage-report-path | Path to the coverage report for the SonarQube analysis | No       | coverage/lcov.info     |