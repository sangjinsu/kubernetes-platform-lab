# Kubernetes Platform Lab

Kubernetes 플랫폼 엔지니어링 핵심 기술을 로컬 kind/Colima 환경에서 실습하기 위한 학습 저장소입니다. Cilium, Gateway API, GitOps, 정책, 관측성, 오토스케일링, Karpenter까지 운영 관점의 작은 랩으로 나누어 검증 가능한 산출물을 남기는 것을 목표로 합니다.

## 빠른 시작

필요 도구를 먼저 확인한다.

```bash
./scripts/install-tools.sh
```

로컬 kind 클러스터를 만든다.

```bash
./scripts/create-kind-cluster.sh
```

랩을 만든 뒤 표준 구조와 shell syntax를 확인한다.

```bash
./scripts/verify-lab.sh labs/local-cilium
```

실습이 끝나면 이 저장소가 만든 기본 클러스터만 삭제한다.

```bash
./scripts/delete-kind-cluster.sh
```

## 저장소 구조

```text
.
├── AGENTS.md
├── apps
├── docs
├── guides
├── labs
├── scripts
└── tests
```

- `AGENTS.md`: 짧은 인덱스와 핵심 원칙
- `guides/`: 세부 작업 지침, 학습 주제, 랩 표준, 검증 정책, 로드맵, 안전 지침
- `scripts/`: 로컬 클러스터 생성/삭제, 도구 확인, 랩 검증 스크립트
- `labs/`: 주제별 실습
- `apps/`: 실습용 sample application
- `tests/`: kubeconform, Helm, Kyverno, e2e 검증 자산

## 첫 학습 순서

1. `labs/local-cilium`
2. `labs/local-gateway-api`
3. `labs/local-argocd`
4. `labs/local-argo-rollouts`
5. `labs/local-kyverno`
6. `labs/local-external-secrets`
7. `labs/local-cert-manager`
8. `labs/local-observability`
9. `labs/local-keda`
10. `labs/cloud-aws-karpenter`

Karpenter는 AWS 비용이 발생할 수 있으므로 로컬 네트워크, GitOps, 정책, 관측성 실습 이후 진행한다.

## 안전 원칙

- kubeconfig, AWS credential, access token, 실제 secret은 저장소에 만들거나 저장하지 않는다.
- AWS/EKS 비용이 발생할 수 있는 실습은 `labs/cloud-*` 아래에만 둔다.
- 사용자의 명시적 요청 없이 `terraform apply`, AWS 리소스 생성, cluster-wide 삭제 명령을 실행하지 않는다.
- 정리 스크립트는 실습에서 만든 명확한 리소스만 대상으로 한다.

## 검증 명령

스크립트 문법을 확인한다.

```bash
bash -n scripts/*.sh
```

랩 구조를 확인한다.

```bash
./scripts/verify-lab.sh labs/local-example
```

manifest를 추가한 랩에서는 kubeconform을 사용한다.

```bash
kubeconform -strict -summary labs/local-example/manifests/
```

Helm chart를 추가한 랩에서는 lint와 렌더링 검증을 함께 수행한다.

```bash
helm lint ./labs/local-example/charts/example
helm template example ./labs/local-example/charts/example > /tmp/example.yaml
kubeconform -strict -summary /tmp/example.yaml
```
