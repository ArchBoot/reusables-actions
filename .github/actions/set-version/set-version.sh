#!/bin/bash
set -euo pipefail

case $STACK in
  "java-maven")
    mvn versions:set -DnewVersion="$NEW_VERSION" -DgenerateBackupPoms=false
    ;;
  "node-npm")
    npm version "$NEW_VERSION" --no-git-tag-version
    ;;
  *)
    echo "Unsupported stack: $STACK"
    exit 1
    ;;
esac
