#! /bin/bash
set -e
set -x

echo "Building ..."
pwd
ls -al

git status 

git log -n 5 --pretty=format:"%h - %an, %ar : %s"

BUILDTAG="build-$TRAVIS_BUILD_NUMBER"

if [ "$TRAVIS_BRANCH" == "develop" ]
then
    ENVTAG='develop'
fi

echo "$DOCKER_PASSWORD_TRAVIS" | docker login -u "$DOCKER_USERNAME_TRAVIS" --password-stdin

DOCKERRPO="nickstanley574/pipeline-demo-protoype"
TAGSTR=""
echo "Build docker image:"
for tag in {$BUILDTAG,$ENVTAG}; do
    $TAGSTR+="-t $DOCKERRPO:$tag "
done

docker build $TAGSTR .

echo "Push Dockerbuild to dockerhub"
docker push nickstanley574/pipeline-demo-protoype:${tag}


echo "Done."