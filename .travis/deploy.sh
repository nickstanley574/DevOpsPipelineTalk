#! /bin/bash
echo "deploying ..."

set -e
set -x 

cat ~/.netrc 

docker logout
docker login -u "$HEROKU_USER" -p "$HEROKU_KEY" registry.heroku.com
HEROKU_DEBUG=true HEROKU_DEBUG_HEADERS=1 heroku container:login



echo "Done!"