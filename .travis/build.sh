#! /bin/bash

set -e
set -x

git log -n 5 --pretty=format:"%h - %an, %ar : %s"

BUILDTAG="build-$TRAVIS_BUILD_NUMBER"

if [ "$TRAVIS_BRANCH" == "develop" ] && [$TRAVIS_EVENT_TYPE == "push"]
then
    ENVTAG='develop'
fi

echo "Build docker image ..."
DOCKERRPO="nickstanley574/pipeline-demo-protoype"
docker build -t "buildimage" .

IMAGE_ID=$(docker images -q buildimage)

echo "Push Docker build to hub.docker.com ..."
echo "$DOCKER_PASSWORD_TRAVIS" | docker login -u "$DOCKER_USERNAME_TRAVIS" --password-stdin
for tag in {$BUILDTAG,$ENVTAG}; do
    docker tag $IMAGE_ID $DOCKERRPO:$tag
    docker push $DOCKERRPO:$tag
done
