#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-kubernetes-platform-lab}"

if ! command -v kind >/dev/null 2>&1; then
  echo "ERROR: required command not found: kind" >&2
  exit 1
fi

if ! kind get clusters | grep -Fxq "$CLUSTER_NAME"; then
  echo "kind cluster not found: $CLUSTER_NAME"
  echo "Nothing changed."
  exit 0
fi

echo "Deleting kind cluster: $CLUSTER_NAME"
kind delete cluster --name "$CLUSTER_NAME"
echo "Deleted kind cluster: $CLUSTER_NAME"
