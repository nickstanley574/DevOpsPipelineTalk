#! /bin/bash
set -e
set -x

echo "Building ..."
pwd
ls -al

if [ "$TRAVIS_BRANCH" == "develop" ]
then
    TAG1='develop'
    TAG2=$(.travis/version.sh)
else
    TAG1=$TRAVIS_COMMIT
    TAG2=$TRAVIS_BUILD_ID
fi

echo "Build docker image:"
docker build -t $TAG1 -t $TAG2 .

echo "Push Dockerbuild to dockerhub"
echo "$DOCKER_PASSWORD_TRAVIS" | docker login -u "$DOCKER_USERNAME_TRAVIS" --password-stdin
docker push nickstanley574/pipeline-demo-protoype:$TAG1
docker push nickstanley574/pipeline-demo-protoype:$TAG2

echo "Done."