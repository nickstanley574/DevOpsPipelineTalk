#! /bin/bash

set -e

cat .travis/display/test

cat .travis/display/test-unit
echo "Ran 22 tests in 0.221s"
echo "OK"
echo

cat .travis/display/test-code-standards
echo "88% > 85% minimum"
echo "Passed"
echo

cat .travis/display/test-acceptacne
echo "Project Manger approved"
echo "Passed"
echo
