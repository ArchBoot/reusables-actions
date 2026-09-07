#!/bin/bash

set -euo pipefail

case "$STACK" in
  "java-maven")
    mvn --batch-mode package -DskipTests
    ;;
  "node-npm")
    npm ci
    ;;
  *)
    echo "Unsupported stack: $STACK"
    exit 1
    ;;
esac