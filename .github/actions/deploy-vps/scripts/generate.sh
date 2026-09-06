#!/bin/bash

set -euo pipefail

cat > docker-compose.yml <<EOF
services:
  ${APP_NAME}:
    image: ${IMAGE}
    container_name: ${APP_NAME}
    restart: unless-stopped
    network:
      - ${NETWORK}
    labels:
      - traefik.enable=true
      - traefik.http.routers.${APP_NAME}.rule=Host(\`${DOMAIN}\`)
      - traefik.http.routers.${APP_NAME}.entrypoints=websecure
      - traefik.http.routers.${APP_NAME}.tls.certresolver=letsencrypt
      - traefik.http.services.${APP_NAME}.loadbalancer.server.port=${CONTAINER_PORT}

networks:
  ${NETWORK}:
    external: true
EOF