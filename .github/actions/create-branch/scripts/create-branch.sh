#!/bin/bash

set -euo pipefail

# Fetch the latest changes from the remote repository
git fetch origin

# Check if the base branch exists
if ! git show-ref --verify --quiet "refs/remotes/origin/$BASE_BRANCH"; then
  echo "Error: Base branch '$BASE_BRANCH' does not exist."
    exit 1
  fi

# Create the new branch from the base branch
git checkout -b "$NEW_BRANCH" "origin/$BASE_BRANCH"

# Optionally push the new branch to the remote repository
if [[ "$PUSH" == "true" ]]; then
  git push origin "$NEW_BRANCH"
  echo "✅ Branch '$NEW_BRANCH' created from '$BASE_BRANCH' and pushed to remote."
else
  echo "✅ Branch '$NEW_BRANCH' created from '$BASE_BRANCH'. Not pushed to remote."
fi