# exit when any command fails
set -e


echo "DEBUG: TRAVIS_BRANCH=$TRAVIS_BRANCH TRAVIS_PULL_REQUEST_BRANCH=$TRAVIS_PULL_REQUEST_BRANCH TRAVIS_EVENT_TYPE=$TRAVIS_EVENT_TYPE"

if [ "$TRAVIS_BRANCH" == "develop" ]
then

    echo "DEVELOP BUILD AND DEPLOYMENT"

elif [ "$TRAVIS_PULL_REQUEST_BRANCH" == "develop" ] && [ "$TRAVIS_BRANCH" == "staging" ]
then 
    echo "DEPLOY TO STAGGING"
    bash .travis/branch.sh "CREATE"

elif [ "$TRAVIS_PULL_REQUEST_BRANCH" == "staging" ] && [ "$TRAVIS_BRANCH" == "master" ]
then 
    echo "DEPLOY TO MASTER"
    bash .travis/branch.sh "RELEASE"
else 
    echo "ELSE: TRAVIS_BRANCH=$TRAVIS_BRANCH TRAVIS_PULL_REQUEST_BRANCH=$TRAVIS_PULL_REQUEST_BRANCH"
fi