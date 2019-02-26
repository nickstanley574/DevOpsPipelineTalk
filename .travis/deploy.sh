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

docker image pull nickstanley574/uicpipeline:$TRAVIS_BRANCH
docker tag nickstanley574/uicpipeline:$TRAVIS_BRANCH registry.heroku.com/uicpipeline-$TRAVIS_BRANCH/web

docker login -u "$HEROKU_USER" -p "$HEROKU_KEY" registry.heroku.com
heroku container:login

docker image ls 

heroku container:push web --app uicpipeline-$TRAVIS_BRANCH
heroku container:release web --app uicpipeline-$TRAVIS_BRANCH