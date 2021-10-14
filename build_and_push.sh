#!/bin/sh

docker build --file Dockerfile --tag sneakykoder/python-cli:latest .
docker build --file Dockerfile --tag sneakykoder/python-cli:3 .

docker push sneakykoder/python-cli:latest
docker push sneakykoder/python-cli:3

