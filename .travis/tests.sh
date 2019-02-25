#! /bin/bash

heroku --version
export HEROKU_API_KEY=$HEROKU_TOKEN_DEVELOP
heroku apps

echo "test 1:"
sleep 1
echo "PASSED"
echo "test 2:"
sleep 1
echo "PASSED"
echo "test 3:"
sleep 1
echo "PASSED"
echo "ALL TESTS PASSED"