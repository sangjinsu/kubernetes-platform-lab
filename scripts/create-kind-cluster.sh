#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-kubernetes-platform-lab}"

require_command() {
  local command_name="$1"

  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "ERROR: required command not found: $command_name" >&2
    exit 1
  fi
}

require_command kind
require_command docker

if ! docker info >/dev/null 2>&1; then
  echo "ERROR: Docker runtime is not available. Start Colima or Docker first." >&2
  exit 1
fi

if kind get clusters | grep -Fxq "$CLUSTER_NAME"; then
  echo "kind cluster already exists: $CLUSTER_NAME"
  echo "Nothing changed."
  exit 0
fi

CONFIG_FILE="$(mktemp "${TMPDIR:-/tmp}/kind-${CLUSTER_NAME}.XXXXXX.yaml")"
trap 'rm -f "$CONFIG_FILE"' EXIT

cat >"$CONFIG_FILE" <<'KIND_CONFIG'
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    kubeadmConfigPatches:
      - |
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
    extraPortMappings:
      - containerPort: 80
        hostPort: 8080
        protocol: TCP
      - containerPort: 443
        hostPort: 8443
        protocol: TCP
  - role: worker
KIND_CONFIG

echo "Creating kind cluster: $CLUSTER_NAME"
kind create cluster --name "$CLUSTER_NAME" --config "$CONFIG_FILE"
echo "Created kind cluster: $CLUSTER_NAME"
