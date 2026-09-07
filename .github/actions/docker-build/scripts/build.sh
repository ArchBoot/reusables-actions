#!/bin/bash

set -euo pipefail

IMAGE="$IMAGE_NAME:$IMAGE_TAG"

docker build --pull --file "$DOCKERFILE" --tag "$IMAGE" "$CONTEXT"

echo "Built image: $IMAGE"

echo "image=$IMAGE" >> "$GITHUB_OUTPUT"