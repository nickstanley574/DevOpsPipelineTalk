#! /bin/bash
echo "deploying ..."

heroku container:login
sleep 10
heroku apps
sleep 10
heroku config
sleep 10

echo "Done!"