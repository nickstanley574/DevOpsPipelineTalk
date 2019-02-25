#! /bin/bash
echo "deploying ..."

set -e
set -x 

docker logout
docker login -u "$HEROKU_USER" -p "$HEROKU_KEY" registry.heroku.com
heroku container:login



echo "Done!"