#!/bin/bash

# dectect docker
if ! [ -x "$(command -v docker)" ]; then
    echo 'ERROR: docker not found, You can goto https://www.docker.com/ install' >&2
    exit 1
fi

GIT_ROOT=$(git rev-parse --show-toplevel)
readonly ROOT=${GIT_ROOT}
readonly DOCKER_NAMESPACE="work4fun"
readonly DOCKER=$(which docker)
readonly DOCKERFILE_NAME="Dockerfile"

# Put the name of the last compilation in an file
readonly LATEST_BUILD_IMAGE_FILE_NAME="WORK4FUN_LATEST_ID"

function update_latest_id() {
    echo ${1} > "${GIT_ROOT}/${LATEST_BUILD_IMAGE_FILE_NAME}"
}

function get_latest_id() {
    cat "${GIT_ROOT}/${LATEST_BUILD_IMAGE_FILE_NAME}"
}