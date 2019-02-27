#! /bin/bash
set -e
cat .travis/display/build
set -x

git log -n 5 --pretty=format:"%h - %an, %ar : %s"

if [ "$TRAVIS_BRANCH" == "develop" ] && [ "$TRAVIS_EVENT_TYPE" == "push" ]
then
    ENVTAG='develop'
fi

BUILDTAG="build-$TRAVIS_BUILD_NUMBER"
DOCKERRPO="nickstanley574/uicpipeline"
docker build --quiet -t "buildimage" .
IMAGE_ID=$(docker images -q buildimage)

echo "$DOCKER_PASSWORD_TRAVIS" | docker login -u "$DOCKER_USERNAME_TRAVIS" --password-stdin
for tag in {$BUILDTAG,$ENVTAG}; do
    docker tag $IMAGE_ID $DOCKERRPO:$tag
    docker push $DOCKERRPO:$tag
done
