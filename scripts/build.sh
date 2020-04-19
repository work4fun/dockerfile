#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPTS_DIR="$(dirname "${BASH_SOURCE}")"
source "${SCRIPTS_DIR}/common.sh"

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

repository_id="$(make_app_name):$(make_version)"

$DOCKER build "$ROOT/$app" -f "$ROOT/$app/${DOCKERFILE_NAME}" -t "$repository_id"

if function_exists "post_build"; then
    post_build
fi

# Put the name of the last compilation in a file
update_latest_id "${repository_id}"