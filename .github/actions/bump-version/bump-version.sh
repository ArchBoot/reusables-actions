#!/bin/bash
set -euo pipefail

IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

PATCH="${PATCH:-0}"

case $BUMP_TYPE in
  "major")
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  "minor")
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  "patch")
    PATCH=$((PATCH + 1))
    ;;
  *)
    echo "Unsupported bump type: $BUMP_TYPE"
    exit 1
    ;;
esac

if [[ "$SNAPSHOT" == "true" ]]; then
  NEXT_VERSION="${MAJOR}.${MINOR}.${PATCH}-SNAPSHOT"
else
  NEXT_VERSION="${MAJOR}.${MINOR}.${PATCH}"
fi

echo "Next version: $NEXT_VERSION"

echo "next_version=$NEXT_VERSION" >> "$GITHUB_OUTPUT"