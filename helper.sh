#!/bin/sh

BUILD=0
PUBLISH=0
CLEAN=0

while [ $# -gt 0 ]; do
    key="$1"

    case $key in
        -c|--clean)
            CLEAN=1
            shift
            ;;
        -b|--build)
            BUILD=1
            shift
            ;;
        -p|--publish)
            PUBLISH=1
            shift
            ;;
  esac
done

IMAGE=sneakykoder/python-cli

if [ $CLEAN = 1 ]; then
    echo "---- Clean ----"
    docker image rm ${IMAGE}:latest
    docker image rm ${IMAGE}:3
fi

if [ $BUILD = 1 ]; then
    echo '---- Build ----'
    docker buildx build \
    --platform linux/amd64 \
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
