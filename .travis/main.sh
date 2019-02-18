

if [ $TRAVIS_BRANCH == "develop"]
then

    echo "DOING STUFF FOR DEVELOP BUILD AND DEPLOYMENT"

# For pull reguest to stagging
elif [ $TRAVIS_PULL_REQUEST_BRANCH == "develop" ] && [ $TRAVIS_BRANCH == "stagging"]
then 
    echo "DEPLOY TO STAGGING"
fi