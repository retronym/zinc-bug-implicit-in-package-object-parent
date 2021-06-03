#! /bin/bash -ex

sbt compile
cp -R src/main-changes/* src/main/
sbt debug compile
sbt last/compileIncremental
