# exit when any command fails
set -e


if [ "$TRAVIS_BRANCH" == "develop" ]
then

    echo "DEVELOP BUILD AND DEPLOYMENT"

# For pull reguest to staging
elif [ "$TRAVIS_PULL_REQUEST_BRANCH" == "develop" ] && [ "$TRAVIS_BRANCH" == "staging" ]
then 
    echo "DEPLOY TO STAGGING"
    bash .travis/branch.sh "CREATE"

# For pull reguest to master
elif [ "$TRAVIS_PULL_REQUEST_BRANCH" == "staging" ] && [ "$TRAVIS_BRANCH" == "master" ]
then 
    echo "DEPLOY TO MASTER"
    bash .travis/branch.sh "RELEASE"
else 
    echo "ELSE: TRAVIS_BRANCH=$TRAVIS_BRANCH"
fi