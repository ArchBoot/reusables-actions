#!/usr/bin/env bash
set -euo pipefail

: "${TICKET_PATTERN:=[A-Z]+-[0-9]+}"
: "${TICKET_SOURCE:=auto}"

extract_ticket() {
  grep -oE "$TICKET_PATTERN" <<< "${1:-}" 2>/dev/null | head -n1 || true
}

get_pr_title() {
  jq -r '.pull_request.title // empty' "$GITHUB_EVENT_PATH" 2>/dev/null || true
}

get_push_commit_messages() {
  jq -r '.commits[]?.message // empty' "$GITHUB_EVENT_PATH" 2>/dev/null || true
}

get_pr_commit_messages() {
  local pr_number
  pr_number=$(jq -r '.pull_request.number // empty' "$GITHUB_EVENT_PATH" 2>/dev/null || true)

  if [ -z "$pr_number" ] || [ -z "${GITHUB_TOKEN:-}" ]; then
    return 0
  fi

  curl -s -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${pr_number}/commits" \
    | jq -r '.[].commit.message // empty'
}

try_branch() {
  local candidate="${GITHUB_HEAD_REF:-$GITHUB_REF_NAME}"
  extract_ticket "$candidate"
}

try_pr_title() {
  extract_ticket "$(get_pr_title)"
}

try_commits() {
  local messages=""
  if [[ "${GITHUB_EVENT_NAME}" == "pull_request" || "${GITHUB_EVENT_NAME}" == "pull_request_target" ]]; then
    messages="$(get_pr_commit_messages)"
  else
    messages="$(get_push_commit_messages)"
  fi
  extract_ticket "$messages"
}

ticket_id=""
source_used=""

case "$TICKET_SOURCE" in
  branch)
    ticket_id="$(try_branch)"; source_used="branch"
    ;;
  pr_title)
    ticket_id="$(try_pr_title)"; source_used="pr_title"
    ;;
  commits)
    ticket_id="$(try_commits)"; source_used="commits"
    ;;
  auto)
    ticket_id="$(try_branch)"; source_used="branch"
    if [ -z "$ticket_id" ]; then ticket_id="$(try_pr_title)"; source_used="pr_title"; fi
    if [ -z "$ticket_id" ]; then ticket_id="$(try_commits)"; source_used="commits"; fi
    ;;
  *)
    echo "::error::Unsupported ticket_source: $TICKET_SOURCE"
    exit 1
    ;;
esac

if [ -z "$ticket_id" ]; then
  source_used=""
  echo "No se detectó ticket id (source: $TICKET_SOURCE)."
  if [ "${FAIL_IF_NOT_FOUND:-false}" == "true" ]; then
    echo "::error::No se encontró ticket Jira usando source '$TICKET_SOURCE'"
    exit 1
  fi
else
  echo "Ticket detectado: $ticket_id (source: $source_used)"
fi

{
  echo "ticket_id=${ticket_id}"
  echo "ticket_source_used=${source_used}"
} >> "$GITHUB_OUTPUT"