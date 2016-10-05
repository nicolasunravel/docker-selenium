#!/bin/bash
VERSION=$1

echo FROM unravel/selenium_base:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
