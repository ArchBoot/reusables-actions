#!/bin/bash

set -euo pipefail

mkdir -p ~/.ssh
chmod 700 ~/.ssh

printf "%s\n" "$SSH_KEY" > ~/.ssh/id_ed25519

chmod 600 ~/.ssh/id_ed25519