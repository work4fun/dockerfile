#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail


SCRIPTS_DIR="$(dirname "${BASH_SOURCE}")"
source "${SCRIPTS_DIR}/common.sh"

$DOCKER push "$(get_latest_id)"