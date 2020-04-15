#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail


SCRIPTS_DIR="$(dirname "${BASH_SOURCE}")"
source "${SCRIPTS_DIR}/common.sh"

if [ -z "$(get_latest_id)" ];then
    echo "latest build docker image not found, retry make build?"
    exit 255
fi

$DOCKER push "$(get_latest_id)"