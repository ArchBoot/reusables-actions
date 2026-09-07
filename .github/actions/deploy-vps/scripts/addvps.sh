#!/bin/bash

set -euo pipefail

ssh-keyscan -p "$PORT" -H "$HOST" >> ~/.ssh/known_hosts
