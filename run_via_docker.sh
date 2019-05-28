#!/bin/bash

TARGET_IMAGE_NAME="xbox-app-vala"
DISPLAY_NAME="host.docker.internal:0"

# allow access from localhost
xhost + 127.0.0.1

# Build docker image
docker build -t $TARGET_IMAGE_NAME .

# Run docker image
docker run -e DISPLAY=$DISPLAY_NAME $TARGET_IMAGE_NAME
