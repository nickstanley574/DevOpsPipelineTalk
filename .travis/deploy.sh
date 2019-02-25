#! /bin/bash
echo "deploying ..."

heroku apps
sleep 10
heroku config
sleep 10

echo "Done!"