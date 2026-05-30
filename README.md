# Kubernetes Platform Lab

Kubernetes 플랫폼 엔지니어링 핵심 기술을 로컬 kind/Colima 환경에서 실습하기 위한 학습 저장소입니다. Cilium, Gateway API, GitOps, 정책, 관측성, 오토스케일링, Terraform/Terragrunt까지 운영 관점의 작은 랩으로 나누어 검증 가능한 산출물을 남기는 것을 목표로 합니다. 대부분의 실습은 로컬에서 진행하고, Karpenter만 명시적 비용 승인 후 AWS EKS 선택 실습으로 다룰 수 있습니다.

## 빠른 시작

필요 도구를 먼저 확인한다.

```bash
./scripts/install-tools.sh
```

로컬 kind 클러스터를 만든다.

```bash
./scripts/create-kind-cluster.sh
```

Chapter 1 문서를 따라 echo 앱을 배포하고 기본 kubectl 루프를 익힌다.

- [Chapter 1. 로컬 Kubernetes 기본](chapters/ch01-local-kubernetes/README.md)

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
├── chapters
├── docs
├── guides
├── labs
├── scripts
└── tests
```

- `AGENTS.md`: 짧은 인덱스와 핵심 원칙
- `chapters/`: 학습 순서별 진입점
- `guides/`: 세부 작업 지침, 학습 주제, 랩 표준, 검증 정책, 로드맵, 안전 지침
- `scripts/`: 로컬 클러스터 생성/삭제, 도구 확인, 랩 검증 스크립트
- `labs/`: 주제별 실습
- `apps/`: 실습용 sample application
- `tests/`: kubeconform, Helm, Kyverno, e2e 검증 자산

## 첫 학습 순서

1. [Chapter 01. 로컬 Kubernetes 기본](chapters/ch01-local-kubernetes/README.md)
2. [Chapter 02. Cilium과 네트워크 정책](chapters/ch02-cilium-networking/README.md)
3. [Chapter 03. Gateway API 라우팅](chapters/ch03-gateway-api/README.md)
4. [Chapter 04. GitOps와 점진적 배포](chapters/ch04-gitops-delivery/README.md)
5. [Chapter 05. 정책과 보안](chapters/ch05-policy-security/README.md)
6. [Chapter 06. Secret과 인증서](chapters/ch06-secrets-certificates/README.md)
7. [Chapter 07. 관측성](chapters/ch07-observability/README.md)
8. [Chapter 08. 오토스케일링](chapters/ch08-autoscaling/README.md)
9. [Chapter 09. Terraform/Terragrunt](chapters/ch09-terraform-terragrunt/README.md)
10. [Chapter 10. Karpenter](chapters/ch10-karpenter/README.md)

Karpenter를 제외한 AWS/EKS/NHN Cloud 실습은 비용 제약 때문에 로컬 실행 실습으로 진행하지 않는다. Karpenter는 기본적으로 개념/설계 문서로 학습하고, 실제 동작 확인이 필요할 때만 명시적 비용 승인 후 AWS EKS에서 제한 실습한다. Terraform/Terragrunt는 로컬 또는 비용 없는 static validation 중심으로만 다룬다.

## 안전 원칙

- kubeconfig, AWS credential, access token, 실제 secret은 저장소에 만들거나 저장하지 않는다.
- AWS/EKS/NHN Cloud 실행 실습은 기본 학습 범위에서 제외한다.
- Karpenter만 명시적 비용 승인 후 AWS EKS 선택 실습으로 다룰 수 있다.
- NHN Cloud NKS는 Karpenter 실행 대상이 아니라 비용 비교와 cluster 삭제 전략 문서로 다룬다.
- 사용자의 명시적 비용 승인 없이 `terraform apply`, `terragrunt run apply`, AWS/NHN Cloud 리소스 생성, cluster-wide 삭제 명령을 실행하지 않는다.
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

Chapter 1 echo manifest를 검증한다.

```bash
kubeconform -strict -summary apps/echo/manifests/
```

Helm chart를 추가한 랩에서는 lint와 렌더링 검증을 함께 수행한다.

```bash
helm lint ./labs/local-example/charts/example
helm template example ./labs/local-example/charts/example > /tmp/example.yaml
kubeconform -strict -summary /tmp/example.yaml
```

Terragrunt 기반 IaC 랩에서는 비용 없는 HCL 검증 중심으로 확인한다.

```bash
terragrunt hcl fmt --check
terragrunt hcl validate
```
