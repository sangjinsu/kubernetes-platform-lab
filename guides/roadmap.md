# 로드맵

## Phase 1. 로컬 클러스터와 배포 기본

목표:

- kind, kubectl, Helm, Kustomize에 익숙해진다.
- 모든 실습의 공통 기반을 만든다.

산출물:

- `scripts/create-kind-cluster.sh`
- `scripts/delete-kind-cluster.sh`
- `apps/echo`
- `docs/phase-01-local-kubernetes.md`

## Phase 2. 네트워크

목표:

- Cilium, Hubble, Gateway API를 실습한다.
- Kubernetes 네트워크 정책과 라우팅을 이해한다.

산출물:

- `labs/local-cilium`
- `labs/local-gateway-api`
- `docs/phase-02-networking.md`

## Phase 3. 배포와 GitOps

목표:

- Argo CD로 GitOps 배포를 이해한다.
- Argo Rollouts로 점진적 배포를 실습한다.

산출물:

- `labs/local-argocd`
- `labs/local-argo-rollouts`
- `docs/phase-03-gitops-delivery.md`

## Phase 4. 보안과 정책

목표:

- Kyverno 정책을 작성하고 테스트한다.
- External Secrets와 cert-manager를 실습한다.

산출물:

- `labs/local-kyverno`
- `labs/local-external-secrets`
- `labs/local-cert-manager`
- `docs/phase-04-security.md`

## Phase 5. 관측성

목표:

- Prometheus, Grafana, Loki, OpenTelemetry를 실습한다.
- 서비스 상태를 지표/로그/트레이스로 확인한다.

산출물:

- `labs/local-observability`
- `docs/phase-05-observability.md`

## Phase 6. 오토스케일링, IaC, 비용 인식

목표:

- HPA와 KEDA를 로컬에서 실습한다.
- Karpenter는 AWS 비용 제약 때문에 개념과 설계 관점으로만 비교한다.
- Terraform/Terragrunt는 비용 없는 validation 중심으로 IaC 구조를 학습한다.

산출물:

- `labs/local-hpa`
- `labs/local-keda`
- `docs/phase-06-autoscaling.md`
- `docs/karpenter-concepts.md`
- `docs/terraform-terragrunt-local-validation.md`

## 우선순위

처음에는 다음 순서로 진행한다.

1. `labs/local-cilium`
2. `labs/local-gateway-api`
3. `labs/local-argocd`
4. `labs/local-argo-rollouts`
5. `labs/local-kyverno`
6. `labs/local-external-secrets`
7. `labs/local-cert-manager`
8. `labs/local-observability`
9. `labs/local-keda`
10. `docs/terraform-terragrunt-local-validation.md`
11. `docs/karpenter-concepts.md`

AWS/EKS/Karpenter는 비용 제약 때문에 실행 실습으로 진행하지 않는다. Karpenter는 로컬 실습 이후 개념과 설계 판단 기준으로만 학습한다.

## 완료 기준

이 저장소의 학습이 어느 정도 완료되었다고 보려면 다음 조건을 만족해야 한다.

- 로컬 kind 클러스터를 스크립트로 생성/삭제할 수 있다.
- Cilium 설치와 NetworkPolicy 테스트를 재현할 수 있다.
- Gateway API로 path routing을 구성할 수 있다.
- Argo CD로 GitOps 배포를 수행할 수 있다.
- Argo Rollouts로 canary 배포와 rollback을 수행할 수 있다.
- Kyverno 정책을 작성하고 실패/성공 케이스를 테스트할 수 있다.
- External Secrets와 cert-manager의 기본 흐름을 이해하고 실습할 수 있다.
- Prometheus/Grafana/Loki/OpenTelemetry 기반 관측성 흐름을 구성할 수 있다.
- HPA/KEDA의 차이를 실습으로 설명할 수 있다.
- Terraform module과 Terragrunt live 구조를 분리하고 static validation 중심으로 검토할 수 있다.
- Karpenter의 NodePool, EC2NodeClass, NodeClaim 개념을 설명하고 AWS 비용이 없는 대체 학습 경로를 선택할 수 있다.
