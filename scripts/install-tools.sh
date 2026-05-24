#!/usr/bin/env bash
set -euo pipefail

TOOLS=(
  kind
  kubectl
  helm
  kubeconform
  kustomize
  cilium
  hubble
  kyverno
  argocd
  terraform
  terragrunt
)

BREW_PACKAGES=(
  kind
  kubectl
  helm
  kubeconform
  kustomize
  cilium-cli
  hubble
  kyverno
  argocd
  terraform
  terragrunt
)

missing_tools=()
missing_brew_packages=()

echo "Checking required tools..."

for index in "${!TOOLS[@]}"; do
  tool="${TOOLS[$index]}"
  brew_package="${BREW_PACKAGES[$index]}"

  if command -v "$tool" >/dev/null 2>&1; then
    printf "  OK      %s\n" "$tool"
  else
    printf "  MISSING %s\n" "$tool"
    missing_tools+=("$tool")
    missing_brew_packages+=("$brew_package")
  fi
done

if [[ "${#missing_tools[@]}" -eq 0 ]]; then
  echo "All required tools are available."
  exit 0
fi

echo
echo "Missing tools: ${missing_tools[*]}"
echo
echo "This script does not install anything automatically."
echo "Install examples with Homebrew:"
echo

for package in "${missing_brew_packages[@]}"; do
  echo "  brew install $package"
done

echo
echo "Review each tool before installing. Terraform and Terragrunt can create billable resources when configured with cloud providers."
echo "AWS is intentionally excluded from the default local learning toolchain."
