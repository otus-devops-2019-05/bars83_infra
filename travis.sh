#!/bin/bash
set -e

DOCKER_IMAGE=express42/otus-homeworks

echo "Run tests"

# Prepare network & run container
docker network create hw-infratest-net
docker run -d -v $(pwd):/srv -v /var/run/docker.sock:/tmp/docker.sock \
    -e DOCKER_HOST=unix:///tmp/docker.sock --cap-add=NET_ADMIN --privileged \
    --device /dev/net/tun --name hw-infratest --network hw-infratest-net $DOCKER_IMAGE
#docker exec -e USER=appuser -it hw-test bash
docker exec -e USER=appuser hw-infratest sh -c "./infra-tests/ansible.sh"
docker exec -e USER=appuser hw-infratest sh -c "./infra-tests/packer.sh"
docker exec -e USER=appuser hw-infratest sh -c "./infra-tests/terraform.sh"
docker container rm -f hw-infratest
docker network rm hw-infratest-net
