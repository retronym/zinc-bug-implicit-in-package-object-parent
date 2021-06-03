#! /bin/bash -ex

sbt compile
cp -R src/main-changes/* src/main/
sbt debug compile || R=$?
git co -f HEAD -- src/main/
exit $R
