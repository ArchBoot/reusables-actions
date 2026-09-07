#!/bin/bash

set -euo pipefail

mkdir -p "$(dirname "$OUTPUT")"

case "$STACK" in
  java-maven)
    cp "$ACTION_PATH/templates/java-spring.Dockerfile" "$OUTPUT"
    ;;
  node-npm)
    cp "$ACTION_PATH/templates/node-nginx.Dockerfile" "$OUTPUT"
    ;;
  *)
    echo "Unsupported stack: $STACK"
    exit 1
    ;;
esac

echo "dockerfile=$OUTPUT" >> "$GITHUB_OUTPUT"