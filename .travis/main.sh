

if [ $TRAVIS_PULL_REQUEST_BRANCH == "develop" ] && [ $TRAVIS_BRANCH == "stagging"]
then 
   ./.travis/release-branch-create.sh 
fi