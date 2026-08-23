#!/usr/bin/env bash
set -euo pipefail

: "${SONAR_HOST_URL:?Environment variable SONAR_HOST_URL is required}"
: "${SONAR_TOKEN:?Environment variable SONAR_TOKEN is required}"
: "${PROJECT_KEY:?Environment variable PROJECT_KEY is required}"
: "${PROJECT_NAME:?Environment variable PROJECT_NAME is required}"

echo "Verifying SonarQube project existence for key: $PROJECT_KEY"

http_code=$(curl -s -o /tmp/search_response.json -w "%{http_code}" -u "${SONAR_TOKEN}:" \
  "${SONAR_HOST_URL}/api/projects/search?projects=${PROJECT_KEY}")

if [ "$http_code" -ge 400 ]; then
  echo "Error consultando SonarQube (HTTP $http_code):"
  cat /tmp/search_response.json
  exit 1
fi

exists=$(jq -r '.components | length' /tmp/search_response.json)

if [ "$exists" -gt 0 ]; then
  echo "Project with key '$PROJECT_KEY' already exists."
  exit 0
fi

echo "Project with key '$PROJECT_KEY' does not exist. Creating project..."

http_code=$(curl -s -o /tmp/create_response.json -w "%{http_code}" -u "${SONAR_TOKEN}:" \
  -X POST "${SONAR_HOST_URL}/api/projects/create" \
  -d "name=${PROJECT_NAME}" \
  -d "project=${PROJECT_KEY}" \
  -d "mainBranch=main")

if [ "$http_code" -ge 400 ]; then
  echo "Error creando el proyecto en SonarQube (HTTP $http_code):"
  cat /tmp/create_response.json
  exit 1
fi

jq . /tmp/create_response.json
echo "Project '$PROJECT_NAME' with key '$PROJECT_KEY' created successfully."
