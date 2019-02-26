#! /bin/bash

set -e

branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
tag=$(echo "$branch" | tr / -)
image="local/uicpipeline/$tag"

.travis/tests.sh
docker build -t "$image" .
BRANCH=$image docker-compose -f local-docker-compose.yml up