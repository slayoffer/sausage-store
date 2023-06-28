#!/bin/bash
set +e
export DB=${DB}
echo $CI_REGISTRY_PASSWORD | docker login -u $CI_REGISTRY_USER $CI_REGISTRY --password-stdin
docker compose up -d --pull always

# docker network create -d bridge sausage_network || true
# docker pull ${CI_REGISTRY_IMAGE}/sausage-backend-report:latest
# docker stop backend-report || true
# docker rm backend-report || true
# set -e
# docker run -d --name backend-report \
#     --network=sausage_network \
#     -e PORT="8080" \
#     -e DB="${DB}&tlsAllowInvalidCertificates=true" \
#     --restart always \
#     --pull always \
#     ${CI_REGISTRY_IMAGE}/sausage-backend-report:latest 