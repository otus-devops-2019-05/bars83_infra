#!/bin/bash
set -e

DOCKER_IMAGE=express42/otus-homeworks

echo "Run tests"

# Prepare network & run container
docker network create hw-test-net
docker run -d -v $(pwd):/srv -v /var/run/docker.sock:/tmp/docker.sock \
    -e DOCKER_HOST=unix:///tmp/docker.sock --cap-add=NET_ADMIN --privileged \
    --device /dev/net/tun --name hw-test --network hw-test-net $DOCKER_IMAGE
docker exec -e USER=appuser hw-test sh -c "./infra-tests/ansible.sh"
docker exec -e USER=appuser hw-test sh -c "./infra-tests/packer.sh"
docker exec -e USER=appuser hw-test sh -c "./infra-tests/terraform.sh"
docker container rm -f hw-test
docker network rm hw-test-net