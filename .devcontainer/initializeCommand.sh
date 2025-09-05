#!/usr/bin/env bash

set -e

PREFIX="👀  "
echo "$PREFIX Running $(basename $0)"

echo "$PREFIX Initializing  GH CLI"

$(dirname $0)/gh-login.sh initialize

 echo "$PREFIX Verify that our docker network already exists"
 if [ -z "$(docker network ls -f "name=docker-network" | grep "docker-network")" ]; then
    echo "$PREFIX Creating docker network"
    docker network create docker-network
else
    echo "$PREFIX Docker network already exists"
fi
docker network ls -f "name=docker-network" | grep "docker-network" 

echo "$PREFIX SUCCESS"
exit 0
