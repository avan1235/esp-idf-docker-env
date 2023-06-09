#!/bin/bash

CONTAINER_NAME="espressif_idf_camera"
IMAGE_TAG="avan1235/espressif-idf-camera:5.0.1"

ssh-keygen -f "/home/avan1235/.ssh/known_hosts" -R "[localhost]:2222"
docker build -t "${IMAGE_TAG}" -f Dockerfile .
docker stop "${CONTAINER_NAME}"
docker rm "${CONTAINER_NAME}"
if [[ "$*" == *"--no-device"* ]]
then
    docker run -d --cap-add sys_ptrace -p 127.0.0.1:2222:22 --name "${CONTAINER_NAME}" "${IMAGE_TAG}"
else
    docker run -d --cap-add sys_ptrace -p 127.0.0.1:2222:22 --device=/dev/ttyACM1 --name "${CONTAINER_NAME}" "${IMAGE_TAG}"
fi
