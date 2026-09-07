#!/bin/bash

set -euo pipefail

if [[ -z "$MESSAGE" ]]; then
  git tag "$TAG"
else
  git tag -a "$TAG" -m "$MESSAGE"
fi

git push origin "$TAG"
echo "✅ Tag '$TAG' created and pushed."