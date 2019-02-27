#! /bin/bash
set -e
cat .travis/display/build
set -x

git log -n 5 --pretty=format:"%h - %an, %ar : %s"

if [ "$TRAVIS_BRANCH" == "develop" ] && [ "$TRAVIS_EVENT_TYPE" == "push" ]
then
    ENVTAG='develop'
fi

cat >build.json <<EOF
{
  "travis_build_web_url": $TRAVIS_BUILD_WEB_URL,
  "travis_build_id": $TRAVIS_BUILD_ID,
  "travis_job_web_url": $TRAVIS_JOB_WEB_URL,
  "travis_job_id": $TRAVIS_JOB_ID"
}
EOF

BUILDTAG="build-$TRAVIS_BUILD_NUMBER"
DOCKERRPO="nickstanley574/uicpipeline"
docker build --quiet -t "buildimage" .
IMAGE_ID=$(docker images -q buildimage)

echo "$DOCKER_PASSWORD_TRAVIS" | docker login -u "$DOCKER_USERNAME_TRAVIS" --password-stdin
for tag in {$BUILDTAG,$ENVTAG}; do
    docker tag $IMAGE_ID $DOCKERRPO:$tag
    docker push $DOCKERRPO:$tag
done

