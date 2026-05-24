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

## 랩 스캐폴드 검증

랩을 추가한 뒤에는 저장소 공통 검증 스크립트를 실행한다.

```bash
./scripts/verify-lab.sh labs/local-example
```
