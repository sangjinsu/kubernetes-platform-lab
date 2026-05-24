#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <lab-path>" >&2
  echo "Example: $0 labs/local-cilium" >&2
}

if [[ "$#" -ne 1 ]]; then
  usage
  exit 2
fi

LAB_PATH="$1"
failures=0

if [[ ! -d "$LAB_PATH" ]]; then
  echo "ERROR: lab path does not exist: $LAB_PATH" >&2
  exit 1
fi

check_required_path() {
  local path="$1"

  if [[ -e "$path" ]]; then
    echo "OK: $path"
  else
    echo "MISSING: $path" >&2
    failures=$((failures + 1))
  fi
}

check_required_path "$LAB_PATH/README.md"
check_required_path "$LAB_PATH/manifests"
check_required_path "$LAB_PATH/scripts"

if [[ -d "$LAB_PATH/manifests" ]]; then
  manifest_count="$(find "$LAB_PATH/manifests" -type f \( -name '*.yaml' -o -name '*.yml' \) | wc -l | tr -d ' ')"

  if [[ "$manifest_count" -gt 0 ]]; then
    if command -v kubeconform >/dev/null 2>&1; then
      echo "Running kubeconform for $LAB_PATH/manifests"
      kubeconform -strict -summary "$LAB_PATH/manifests" || failures=$((failures + 1))
    else
      echo "SKIP: kubeconform is not installed."
    fi
  else
    echo "SKIP: no manifest YAML files found in $LAB_PATH/manifests"
  fi
fi

if [[ -d "$LAB_PATH/scripts" ]]; then
  script_count=0

  while IFS= read -r script_file; do
    script_count=$((script_count + 1))
    echo "Checking shell syntax: $script_file"
    bash -n "$script_file" || failures=$((failures + 1))
  done < <(find "$LAB_PATH/scripts" -type f -name '*.sh' | sort)

  if [[ "$script_count" -eq 0 ]]; then
    echo "SKIP: no shell scripts found in $LAB_PATH/scripts"
  fi
fi

if [[ "$failures" -gt 0 ]]; then
  echo "Lab verification failed with $failures issue(s)." >&2
  exit 1
fi

echo "Lab verification passed: $LAB_PATH"
