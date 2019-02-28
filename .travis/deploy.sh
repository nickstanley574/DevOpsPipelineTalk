#! /bin/bash
set -e
cat .travis/display/deploy
set -x

TAG="$TRAVIS_BRANCH"
APP="uicpipeline-$TAG"

if [ "$TRAVIS_BRANCH" == "stage" ]
then 
BASE="develop"
PROMOT="stage"
echo "YOU SHALL NOT PASS!!!"
exit 2 

elif  [ "$TRAVIS_BRANCH" == "master" ]
then
BASE="stage"
PROMOT="latest"
TAG="latest"
APP="uicpipeline"
fi

if [ "$TRAVIS_BRANCH" == 'develop' ]
then
docker image pull nickstanley574/uicpipeline:develop
else
docker image pull nickstanley574/uicpipeline:$BASE
docker tag nickstanley574/uicpipeline:$BASE nickstanley574/uicpipeline:$PROMOT
echo "$DOCKER_PASSWORD_TRAVIS" | docker login -u "$DOCKER_USERNAME_TRAVIS" --password-stdin
docker push nickstanley574/uicpipeline:$PROMOT
fi

docker tag nickstanley574/uicpipeline:$TAG registry.heroku.com/$APP/web
docker image ls 
docker login -u "$HEROKU_USER" -p "$HEROKU_KEY" registry.heroku.com
docker push registry.heroku.com/$APP/web

cat >~/.netrc <<EOF
machine api.heroku.com
    login $HEROKU_USER
    password $HEROKU_KEY
machine git.heroku.com
    login $HEROKU_USER
    password $HEROKU_KEY
EOF

heroku container:login
# heroku container:push web --app $APP
heroku container:release web --app $APP