if [ $TRAVIS ] && [ $CI ]; 
then

VERSIONFILE='.travis/version.yml'

major=$(grep 'major' $VERSIONFILE | awk '{ print $2}')
minor=$(grep 'minor' $VERSIONFILE | awk '{ print $2}')
emerg=$(grep 'emerg' $VERSIONFILE | awk '{ print $2}')

minor=$((minor+1))

release="release/$major.$minor.$emerg"

git checkout -b $release develop

cat >$VERSIONFILE <<EOL
# DEVLELOPERS DO NOT TOUCH THIS FILE!!
major: ${major}
minor: ${minor}
emerg: ${emerg}
EOL

git add '.travis/version.yml'

git commit -a -m "Bumped version number to $release"

else

echo "This script is meant to TravisCI you should NOT run this!!!"
exit 1
fi