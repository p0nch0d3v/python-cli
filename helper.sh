#!/bin/sh

BUILD=0
PUBLISH=0
CLEAN=0
PLATTAFORM=linux/amd64
BASE=python:3
IMAGE=sneakykoder/python-cli

while [ $# -gt 0 ]; do
    key="$1"

    case $key in
        -c|--clean)
            CLEAN=1
            shift
            ;;
        -b|--build)
            BUILD=1
            PLATTAFORM="$2"
            shift
            ;;
        -p|--publish)
            PUBLISH=1
            shift
            ;;
  esac
done

if [ -z $PLATTAFORM ]; then
    PLATTAFORM='linux/amd64'
fi

if [ $CLEAN = 1 ]; then
    echo "---- Clean ----"
    docker image rm ${IMAGE}:latest
    docker image rm ${IMAGE}:3
fi

if [ $BUILD = 1 ]; then
    echo '---- Build ----'
    echo 'Platform: '${PLATTAFORM}
    docker pull ${BASE} --platform ${PLATTAFORM}
    
    docker buildx build \
    --platform ${PLATTAFORM} \
    --no-cache \
    --file Dockerfile \
    --tag ${IMAGE}:3 \
    --tag ${IMAGE}:latest .
fi

if [ $PUBLISH = 1 ]; then
    echo '---- Publish ----'
    docker push ${IMAGE}:latest
    docker push ${IMAGE}:3
fi
