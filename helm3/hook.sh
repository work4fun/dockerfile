#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

CONTEXT=$(dirname "$BASH_SOURCE")
echo "$CONTEXT"

function pre_build() {
    echo "kubeconfig copying..."
    cp -r "$HOME/.kube/" "$CONTEXT/kube"
}

function post_build() {
    echo "kubeconfig cleaning..."
    rm -rf "$CONTEXT/kube"
}