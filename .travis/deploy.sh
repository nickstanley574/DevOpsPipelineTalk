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

docker image pull nickstanley574/pipeline-demo-protoype:develop
docker tag nickstanley574/pipeline-demo-protoype:develop registry.heroku.com/develop-simplelookup/web

docker login -u "$HEROKU_USER" -p "$HEROKU_KEY" registry.heroku.com
heroku container:login

docker image ls 



heroku --app develop-simplelookup container:push web
heroku --app develop-simplelookup container:release web
 



echo "Done!"