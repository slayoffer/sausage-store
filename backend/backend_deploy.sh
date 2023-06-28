#!/bin/bash
set +e
export SPRING_CLOUD_VAULT_TOKEN=${SPRING_CLOUD_VAULT_TOKEN}
echo $CI_REGISTRY_PASSWORD | docker login -u $CI_REGISTRY_USER $CI_REGISTRY --password-stdin
docker compose up -d --pull always

# docker network create -d bridge sausage_network || true
# docker pull ${CI_REGISTRY_IMAGE}/sausage-backend:latest
# docker stop backend || true
# docker rm backend || true
# set -e
# docker run -d --name backend \
#     --network=sausage_network \
#     -v /opt/log/reports:/app/reports \
#     -e REPORT_PATH="/app/reports" \
#     --restart always \
#     --pull always \
#     --env-file .env \
#     ${CI_REGISTRY_IMAGE}/sausage-backend:latest 