#!/bin/bash
VERSION=$1

echo FROM unravel/node-base:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
