#!/usr/bin/env bash
set -euo pipefail

: "${SONAR_HOST_URL:?Environment variable SONAR_HOST_URL is required}"
: "${SONAR_TOKEN:?Environment variable SONAR_TOKEN is required}"
: "${PROJECT_KEY:?Environment variable PROJECT_KEY is required}"
: "${STACK:?Environment variable STACK is required}":
: "${BRANCH_NAME:?Environment variable BRANCH_NAME is required}"

case $STACK in
  "java-maven")

  echo "Running SonarQube scan for Java Maven project on branch: $BRANCH_NAME"
    mvn sonar:sonar \
      -Dsonar.projectKey="$PROJECT_KEY" \
      -Dsonar.host.url="$SONAR_HOST_URL" \
      -Dsonar.login="$SONAR_TOKEN" \
      -Dsonar.branch.name="$BRANCH_NAME" \
      -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
    ;;
  "node-npm")
    echo "Install sonar-scanner CLI..."
    npm install -g @sonar/scan --silent

    sonar-scanner \
      -Dsonar.projectKey="$PROJECT_KEY" \
      -Dsonar.host.url="$SONAR_HOST_URL" \
      -Dsonar.login="$SONAR_TOKEN" \
      -Dsonar.branch.name="$BRANCH_NAME" \
      -Dsonar.sources="$SOURCES" \
      -Dsonar.javascript.lcov.reportPaths="$COVERAGE_PATH" \
      -Dsonar.typescript.lcov.reportPaths="$COVERAGE_PATH"
    ;;
  *)
    echo "Unsupported stack: $STACK"
    exit 1
    ;;
esac
