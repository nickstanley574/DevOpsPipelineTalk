#! /bin/bash
echo "deploying ..."

docker logout
docker login -u $HEROKU_USER -p $HEROKU_KEY
heroku container:login
sleep 10
heroku apps
sleep 10
heroku config
sleep 10

echo "Done!"