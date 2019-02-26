#! /bin/bash
echo "deploying ..."

set -e
set -x 

cat >~/.netrc <<EOF
machine api.heroku.com
    login $HEROKU_USER
    password $HEROKU_KEY
machine git.heroku.com
    login $HEROKU_USER
    password $HEROKU_KEY
EOF

if [ "$TRAVIS_BRANCH" == "master"]
then
TAG="latest"
APP="uicpipeline"
else
TAG=$TRAVIS_BRANCH
APP="uicpipeline-$TRAVIS_BRANCH"
fi

docker image pull nickstanley574/uicpipeline:$TAG
docker tag nickstanley574/uicpipeline:$TAG registry.heroku.com/uicpipeline-$TAG/web

docker login -u "$HEROKU_USER" -p "$HEROKU_KEY" registry.heroku.com
heroku container:login

docker image ls 

heroku container:push web --app $APP
heroku container:release web --app $APP