#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

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

get_apps() {
    ls -d */ | grep -v scripts | sed 's/\///g'
}

make_app_name() {
    echo "$DOCKER_NAMESPACE/$app"
}

make_version() {
    echo $(date +%Y%m%d%H%M%S)
}

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

app=${1:-""}

if [[ -z "$app" ]]; then
    apps=$(get_apps)
    echo -e "$apps \nchooes:"
    read -r app
fi

if [ ! -x "$ROOT/$app" ]; then
    echo "${app} not found"
fi

if [ -f "$ROOT/$app/hook.sh" ]; then
    echo "import $ROOT/$app/hook.sh"
    source "$ROOT/$app/hook.sh"
fi

if function_exists "pre_build"; then
    pre_build
fi

$DOCKER build "$ROOT/$app" -f "$ROOT/$app/${DOCKERFILE_NAME}" -t "$(make_app_name):$(make_version)"

if function_exists "post_build"; then
    post_build
fi