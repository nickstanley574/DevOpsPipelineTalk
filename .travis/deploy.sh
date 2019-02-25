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

docker login -u "$HEROKU_USER" -p "$HEROKU_KEY" registry.heroku.com

HEROKU_DEBUG=true HEROKU_DEBUG_HEADERS=1 heroku container:login



echo "Done!"