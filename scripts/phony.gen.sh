#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

SCRIPTS_DIR="$(dirname "${BASH_SOURCE}")"
source "${SCRIPTS_DIR}/common.sh"

apps=$(get_apps)
phony_content=""
newline=$'\n'

for app in $apps
do
    phony_content="$phony_content.PHONY: $app$newline"
done
cat>"${ROOT}/PHONYMakefile"<<EOF
${phony_content}
EOF

echo "update phony file success!"