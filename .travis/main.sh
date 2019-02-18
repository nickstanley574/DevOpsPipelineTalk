# exit when any command fails
set -e


if [ "$TRAVIS_BRANCH" == "develop" ]
then

    echo "DEVELOP BUILD AND DEPLOYMENT"

# For pull reguest to stagging
elif [ "$TRAVIS_PULL_REQUEST_BRANCH" == "develop" ] && [ "$TRAVIS_BRANCH" == "stagging" ]
then 
    echo "DEPLOY TO STAGGING"
    bash .travis/branch.sh "CREATE"

# For pull reguest to stagging
elif [ "$TRAVIS_PULL_REQUEST_BRANCH" == "stagging" ] && [ "$TRAVIS_BRANCH" == "MASTER" ]
then 
    echo "DEPLOY TO MASTER"
    bash .travis/branch.sh "RELEASE"
else 
    echo "ELSE: TRAVIS_BRANCH=$TRAVIS_BRANCH"
fi