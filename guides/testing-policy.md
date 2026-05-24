# 테스트 정책

Codex는 manifest나 chart를 추가할 때 가능한 한 다음 검증을 포함한다.

## YAML / Kubernetes manifest 검증

```bash
kubeconform -strict -summary manifests/
```

## Helm chart 검증

```bash
helm lint ./charts/example
helm template example ./charts/example > /tmp/example.yaml
kubeconform -strict -summary /tmp/example.yaml
```

## Kubernetes 리소스 기동 검증

```bash
kubectl wait --for=condition=Available deployment/example -n example --timeout=120s
kubectl get pods -n example
kubectl get events -n example --sort-by=.lastTimestamp
```

## 네트워크 검증

```bash
kubectl run curl -n default --rm -it --image=curlimages/curl -- sh
```

## Cilium 검증

```bash
cilium status
cilium connectivity test
hubble observe
```

## Kyverno 정책 검증

```bash
kyverno test ./tests/kyverno
```

## Argo CD 검증

```bash
argocd app get sample-app
argocd app diff sample-app
argocd app sync sample-app
```

## Terraform/Terragrunt 검증

Terraform 단독 랩에서는 AWS provider 없이 비용 없는 static validation 중심으로 검증한다.

```bash
terraform fmt -check -recursive
terraform validate
```

Terragrunt 랩에서는 HCL 검증 중심으로 검증한다.

```bash
terragrunt hcl fmt --check
terragrunt hcl validate
```

AWS provider나 유료 리소스를 만들 수 있는 provider가 없는 local-only 예제에서만 plan을 사용한다.

```bash
terraform plan
terragrunt run plan
terragrunt run --all plan
```

`terraform apply`, `terragrunt run apply`, `terragrunt run --all apply`, `destroy` 계열 명령은 사용자의 명시적 비용 승인 없이 실행 대상으로 작성하지 않는다.

## 랩 스캐폴드 검증

랩을 추가한 뒤에는 저장소 공통 검증 스크립트를 실행한다.

```bash
./scripts/verify-lab.sh labs/local-example
```
