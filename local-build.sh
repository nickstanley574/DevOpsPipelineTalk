#! /bin/bash

set -e

branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
tag=$(echo "$branch" | tr / -)
image="local/uicpipeline/$tag"

cat >build.json <<EOF
{
  "travis_build_web_url": "Hello World",
  "travis_build_id": "123456789",
  "travis_job_web_url": "Hello World2",
  "travis_job_id": "987654321"
}
EOF

docker build -t "$image" .
BRANCH=$image docker-compose -f local-docker-compose.yml up