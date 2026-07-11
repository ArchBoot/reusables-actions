#!/usr/bin/env bash
set -euo pipefail

: "${SONAR_HOST_URL:?Environment variable SONAR_HOST_URL is required}"
: "${SONAR_TOKEN:?Environment variable SONAR_TOKEN is required}"
: "${PROJECT_KEY:?Environment variable PROJECT_KEY is required}"
: "${PROJECT_NAME:?Environment variable PROJECT_NAME is required}"

echo "Verifying SonarQube project existence for key: $PROJECT_KEY"

response=$(curl -sf -u "${SONAR_TOKEN}:" \
  "${SONAR_HOST_URL}/api/projects/search?projects=${PROJECT_KEY}")

exists=$(echo "$response" | jq -r '.components | length')

if [ "$exists" -gt 0 ]; then
  echo "Project with key '$PROJECT_KEY' already exists."
  exit 0
fi

echo "Project with key '$PROJECT_KEY' does not exist. Creating project..."
curl -sf -u "${SONAR_TOKEN}:" \
  -X POST "${SONAR_HOST_URL}/api/projects/create" \
  -d "name=${PROJECT_NAME}" \
  -d "project=${PROJECT_KEY}" \
  -d "mainBranch=main" \
  | jq .

echo "Project '$PROJECT_NAME' with key '$PROJECT_KEY' created successfully."
