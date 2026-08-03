#!/bin/bash

set -euo pipefail

case "$STACK" in
  "java-maven")
    mvn test
    ;;
  "node-npm")
    npm test --if-present
    ;;
  *)
    echo "Unsupported stack: $STACK"
    exit 1
    ;;
esac