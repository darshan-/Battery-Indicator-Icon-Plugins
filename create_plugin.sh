#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 plugin-name"
    exit
fi

cp -ar skeleton-plugin-dir plugin-$1
rm -rf plugin-$1/.svn
rm -rf plugin-$1/*/.svn
rm -rf plugin-$1/*/*/.svn
rm -rf plugin-$1/*/*/.svn
rm -rf plugin-$1/*/*/*/.svn
rm -rf plugin-$1/*/*/*/.svn
rm -rf plugin-$1/*/*/*/*/.svn
rm -rf plugin-$1/*/*/*/*/*/.svn
rm -rf plugin-$1/*/*/*/*/*/*/.svn
rm -rf plugin-$1/*/*/*/*/*/*/*/.svn
rm -rf plugin-$1/*/*/*/*/*/*/*/*/.svn

# set name in AndroidManifest.xml and res/values/strings.xml
# add to svn, then set up svn:ignore props
