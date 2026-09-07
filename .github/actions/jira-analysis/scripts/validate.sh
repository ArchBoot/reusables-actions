#!/usr/bin/env bash
set -euo pipefail

: "${JIRA_BASE_URL:?Environment variable JIRA_BASE_URL is required}"
: "${JIRA_EMAIL:?Environment variable JIRA_EMAIL is required}"
: "${JIRA_API_TOKEN:?Environment variable JIRA_API_TOKEN is required}"

if [ -z "${TICKET_ID:-}" ]; then
  echo "No ticket id detected, skipping Jira validation."
  {
    echo "exists=false"
    echo "status="
    echo "issue_type="
    echo "valid=false"
    echo "summary<<EOF"
    echo "EOF"
  } >> "$GITHUB_OUTPUT"
  exit 0
fi

echo "Validating ticket $TICKET_ID against Jira..."

http_code=$(curl -s -o /tmp/jira_response.json -w "%{http_code}" \
  -u "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  -H "Accept: application/json" \
  "${JIRA_BASE_URL}/rest/api/3/issue/${TICKET_ID}?fields=status,issuetype,summary")

if [ "$http_code" == "404" ]; then
  echo "Ticket $TICKET_ID not found in Jira."
  {
    echo "exists=false"
    echo "status="
    echo "issue_type="
    echo "valid=false"
    echo "summary<<EOF"
    echo "EOF"
  } >> "$GITHUB_OUTPUT"

  if [ "${FAIL_ON_INVALID:-false}" == "true" ]; then
    echo "::error::Ticket $TICKET_ID does not exist in Jira"
    exit 1
  fi
  exit 0
fi

if [ "$http_code" -ge 400 ]; then
  echo "Error querying Jira (HTTP $http_code):"
  cat /tmp/jira_response.json
  exit 1
fi

status="$(jq -r '.fields.status.name' /tmp/jira_response.json)"
issue_type="$(jq -r '.fields.issuetype.name' /tmp/jira_response.json)"
summary="$(jq -r '.fields.summary' /tmp/jira_response.json)"

echo "Ticket found: $TICKET_ID [$issue_type] - $summary (status: $status)"

valid=true
if [ -n "${ALLOWED_STATUSES:-}" ]; then
  match=false
  IFS=',' read -ra STATUSES <<< "$ALLOWED_STATUSES"
  for s in "${STATUSES[@]}"; do
    trimmed="$(echo "$s" | xargs)"
    if [ "$trimmed" == "$status" ]; then
      match=true
      break
    fi
  done
  if [ "$match" == "false" ]; then
    valid=false
    echo "Ticket status '$status' is not in the allowed list: $ALLOWED_STATUSES"
  fi
fi

{
  echo "exists=true"
  echo "status=${status}"
  echo "issue_type=${issue_type}"
  echo "valid=${valid}"
  echo "summary<<EOF"
  echo "${summary}"
  echo "EOF"
} >> "$GITHUB_OUTPUT"

if [ "$valid" == "false" ] && [ "${FAIL_ON_INVALID:-false}" == "true" ]; then
  echo "::error::Ticket $TICKET_ID status '$status' is not in the allowed list"
  exit 1
fi  