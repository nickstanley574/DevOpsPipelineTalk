if [ $TRAVIS ] && [ $CI ]
then

VERSIONFILE='.travis/version.yml'

major=$(grep 'major' $VERSIONFILE | awk '{ print $2}')
minor=$(grep 'minor' $VERSIONFILE | awk '{ print $2}')
emerg=$(grep 'emerg' $VERSIONFILE | awk '{ print $2}')

minor=$((minor+1))

release="release/$major.$minor.$emerg"

git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"
git config --global github.token $GH_TOKEN_TRAVISCI  

git checkout -b $release develop

cat >$VERSIONFILE <<EOL
# DEVLELOPERS DO NOT TOUCH THIS FILE!!
major: ${major}
minor: ${minor}
emerg: ${emerg}
EOL

git add '.travis/version.yml'

git commit -a -m "Travis build: $TRAVIS_BUILD_NUMBER: Bumped version number to $release"

git push --all origin

else

echo "This script is meant to TravisCI you should NOT run this!!!"
exit 1
fi