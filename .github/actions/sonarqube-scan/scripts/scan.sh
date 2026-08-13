#!/usr/bin/env bash
set -euo pipefail

: "${SONAR_HOST_URL:?Environment variable SONAR_HOST_URL is required}"
: "${SONAR_TOKEN:?Environment variable SONAR_TOKEN is required}"
: "${PROJECT_KEY:?Environment variable PROJECT_KEY is required}"
: "${STACK:?Environment variable STACK is required}"
: "${ANALISYS_TYPE:?Environment variable ANALISYS_TYPE is required}"

if [[ "$ANALISYS_TYPE" == "pull_request" ]]; then
  : "${PR_KEY:?PR_KEY is required for pull_request analysis}"
  : "${PR_BRANCH:?PR_BRANCH is required for pull_request analysis}"
  : "${PR_BASE:?PR_BASE is required for pull_request analysis}"

  CONTEXT_ARGS=(
    "-Dsonar.pullrequest.key=$PR_KEY"
    "-Dsonar.pullrequest.branch=$PR_BRANCH"
    "-Dsonar.pullrequest.base=$PR_BASE"
  )

  echo "Running SonarQube scan for PR #$PR_KEY ($PR_BRANCH -> $PR_BASE) "
else
  : "${BRANCH_NAME:?BRANCH_NAME is required for branch analysis}"
  CONTEXT_ARGS=("-Dsonar.branch.name=$BRANCH_NAME")
  echo "Running SonarQube scan for branch: $BRANCH_NAME"
fi


QG_ARGS=()
if [ "${QUALIY_GATE_WAIT:-false}" == "true" ]; then
  QR_ARGS=("-Dsonar.qualitygate.wait=true")
fi

case $STACK in
  "java-maven")

  echo "Running SonarQube scan for Java Maven project on branch: $BRANCH_NAME"
    mvn sonar:sonar \
      -Dsonar.projectKey="$PROJECT_KEY" \
      -Dsonar.host.url="$SONAR_HOST_URL" \
      -Dsonar.login="$SONAR_TOKEN" \
      -Dsonar.branch.name="$BRANCH_NAME" \
      -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml \
      "${CONTEXT_ARGS[@]}" \
      "${QR_ARGS[@]}"
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
      -Dsonar.typescript.lcov.reportPaths="$COVERAGE_PATH" \
      "${CONTEXT_ARGS[@]}" \
      "${QR_ARGS[@]}"
    ;;
  *)
    echo "Unsupported stack: $STACK"
    exit 1
    ;;
esac
