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

## Phase 6. 오토스케일링과 비용 최적화

목표:

- HPA, KEDA, Karpenter를 비교한다.
- 로컬에서는 HPA/KEDA를 실습하고, AWS에서는 Karpenter를 실습한다.

산출물:

- `labs/local-hpa`
- `labs/local-keda`
- `labs/cloud-aws-karpenter`
- `docs/phase-06-autoscaling.md`

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
10. `labs/cloud-aws-karpenter`

Karpenter는 중요하지만 비용과 AWS 의존성이 있으므로 로컬 네트워크, GitOps, 정책, 관측성 실습 이후 진행한다.

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
- Karpenter의 NodePool, EC2NodeClass, NodeClaim 흐름을 설명하고 EKS에서 적용 절차를 설계할 수 있다.
