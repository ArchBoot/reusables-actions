#!/bin/bash

set -euo pipefail

STACK="none"
VERSION=""

if [ -f "pom.xml" ]; then
  STACK="java-maven"

  VERSION=$(grep -oPm1 '(?<=<maven.compiler.release>)[^<]+' pom.xml || true)

  if [[ -z "$VERSION" ]]; then
    VERSION=$(grep -oPm1 '(?<=<maven.compiler.source>)[^<]+' pom.xml || true)
  fi

  # Spring Boot Pom
  if [[ -z "$VERSION" ]]; then
    VERSION=$(grep -oPm1 '(?<=<java.version>)[^<]+' pom.xml || true)
  fi

elif [ -f "package.json" ]; then
  STACK="node-npm"
  if command -v jq >/dev/null 2>&1; then
    VERSION=$(jq -r '.engines.node // empty' package.json)
  fi

  if [[ -z "$VERSION" && -f ".nvmrc" ]]; then
    VERSION=$(cat .nvmrc)
  fi
fi

{
  echo "stack=$STACK"
  echo "stack_version=$VERSION"
} >> "$GITHUB_OUTPUT"