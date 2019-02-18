set -x
set -e

if [ $TRAVIS ] && [ $CI ]
then
echo "We are in a TravisCI env script continuing..."
else
echo "This script is meant to run ONLY TravisCI you should NOT run this!!!"
exit 1
fi

ACTION=$1

VERSIONFILE='.travis/version.yml'
major=$(grep 'major' $VERSIONFILE | awk '{ print $2}')
minor=$(grep 'minor' $VERSIONFILE | awk '{ print $2}')
emerg=$(grep 'emerg' $VERSIONFILE | awk '{ print $2}')

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"


if [ "$ACTION" == "CREATE"]
then

minor=$((minor+1))
release="release/$major.$minor.$emerg"

git checkout -b $release develop

cat >$VERSIONFILE <<EOL
# DEVLELOPERS DO NOT TOUCH THIS FILE!!
major: ${major}
minor: ${minor}
emerg: ${emerg}
EOL

git add "$VERSIONFILE"

git commit -a -m "Travis build: $TRAVIS_BUILD_NUMBER: Bumped version number to $release"

git remote rm origin
git remote add origin https://nickstanley574:${GH_TOKEN_TRAVISCI}@github.com/nickstanley574/pipeline-demo-protoype.git

git push --all origin

elif [ "$ACTION" == "RELEASE"]
then 

release="release/$major.$minor.$emerg"
git checkout master
git merge --no-ff $release
git checkout develop
git merge --no-ff $release
git tag -a $release -m "Travis build: $TRAVIS_BUILD_NUMBER: Tag version $release"
git branch -d $release

git push --all origin


else 
echo "ACTION $ACTION not reconized!"
exit 1
fi 