#! /bin/bash
set -e

#[Todo] PreCheck
echo "**** ENV VARs *****"
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH"
echo "TRAVIS_EVENT_TYPE=$TRAVIS_EVENT_TYPE"
echo "TRAVIS_BUILD_NUMBER=$TRAVIS_BUILD_NUMBER"
echo "TRAVIS_BUILD_ID=$TRAVIS_BUILD_ID"
echo 

#Build
if [ "$TRAVIS_BRANCH" == "develop" ]
then
.travis/build.sh
fi

#Tests 
echo "TESTS"
.travis/tests.sh


#Deploy (https://unix.stackexchange.com/questions/111508/bash-test-if-word-is-in-set)
if [[ $TRAVIS_BRANCH  =~ ^(develop|stage|master)$ ]] && [ $TRAVIS_EVENT_TYPE == 'pull_request' ]
then
.travis/deploy.sh
fi

#[Todo] Post Checks 