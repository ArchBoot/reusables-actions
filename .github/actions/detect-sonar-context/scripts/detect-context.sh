#!/usr/bin/env bash
set -euo pipefail

if [[ "${GITHUB_EVENT_NAME}" == "pull_request" || "${GITHUB_EVENT_NAME}" == "pull_request_target" ]]; then
  pr_key="${GITHUB_REF#refs/pull/}"
  pr_key="${pr_key%/merge}"
  echo "Detected PR analysis: #$pr_key (${GITHUB_HEAD_REF} -> ${GITHUB_BASE_REF})"

  {
    echo "analysis_type=pull_request"
    echo "pr_key=${pr_key}"
    echo "pr_branch=${GITHUB_HEAD_REF}"
    echo "pr_base=${GITHUB_BASE_REF}"
    echo "branch_name="
  } >> "$GITHUB_OUTPUT"
else
  echo "Detected branch analysis: ${GITHUB_REF_NAME}"
  {
      echo "analysis_type=branch"
      echo "pr_key="
      echo "pr_branch="
      echo "pr_base="
      echo "branch_name=${GITHUB_REF_NAME}"
    } >> "$GITHUB_OUTPUT"
fi