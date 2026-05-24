# 랩 표준

## 권장 디렉터리 구조

```text
.
├── AGENTS.md
├── README.md
├── apps
│   ├── echo
│   └── sample-api
├── docs
│   ├── phase-01-local-kubernetes.md
│   ├── phase-02-networking.md
│   ├── phase-03-gitops-delivery.md
│   ├── phase-04-security.md
│   ├── phase-05-observability.md
│   └── phase-06-autoscaling.md
├── guides
├── labs
│   ├── local-cilium
│   ├── local-gateway-api
│   ├── local-argocd
│   ├── local-argo-rollouts
│   ├── local-kyverno
│   ├── local-external-secrets
│   ├── local-cert-manager
│   ├── local-observability
│   ├── local-hpa
│   └── local-keda
├── scripts
│   ├── create-kind-cluster.sh
│   ├── delete-kind-cluster.sh
│   ├── install-tools.sh
│   └── verify-lab.sh
└── tests
    ├── kubeconform
    ├── helm
    ├── kyverno
    └── e2e
```

## 각 랩의 표준 구성

각 `labs/*` 디렉터리는 다음 구조를 따른다.

```text
labs/local-example
├── README.md
├── manifests
├── helm-values
├── scripts
│   ├── install.sh
│   ├── verify.sh
│   └── cleanup.sh
└── tests
```

각 랩의 `README.md`는 다음 순서를 따른다.

1. 목표
2. 아키텍처
3. 사전 준비
4. 설치
5. 튜토리얼
6. 검증
7. 실패 케이스
8. 정리
9. 운영 관점 메모
10. 다음 학습 주제

## 코드 스타일

- Shell script는 `set -euo pipefail`을 사용한다.
- namespace는 랩마다 명확히 분리한다.
- resource name은 `lab-*` 접두어를 사용한다.
- manifest는 가능한 한 작게 유지한다.
- 실습용 이미지는 공식 nginx, curlimages/curl, hashicorp/http-echo 등 검증 쉬운 이미지를 우선한다.
- Helm values는 기본값 전체 복사 대신 필요한 값만 작성한다.
- Terraform은 module과 variable을 명확히 분리하고, 기본 예제는 비용 없는 provider 또는 static validation 중심으로 작성한다.
- Terragrunt는 공통 설정과 environment별 unit을 분리하고, 기본 검증은 HCL validation 중심으로 작성한다.
- README에는 실행 순서와 예상 결과를 함께 적는다.

## Terragrunt 문서 표준 구성

Terragrunt를 다루는 문서는 AWS 실행 랩이 아니라 `docs/` 아래 비용 없는 IaC 구조 학습으로 작성한다.

```text
docs/terraform-terragrunt-local-validation.md
examples/terraform-terragrunt
├── README.md
├── modules
│   └── example
├── live
│   ├── root.hcl
│   ├── dev
│   │   └── example
│   │       └── terragrunt.hcl
│   └── terragrunt.stack.hcl
└── scripts
    ├── validate.sh
    ├── plan.sh
    └── cleanup.md
```

Terragrunt 문서는 다음 내용을 반드시 포함한다.

1. AWS/EKS를 사용하지 않는다는 전제
2. 비용 없는 provider 또는 static validation 범위
3. module과 live 디렉터리 역할
4. `terragrunt.hcl`과 `root.hcl` 관계
5. dependency 구성
6. `terragrunt hcl fmt` 또는 CI 검증용 `terragrunt hcl fmt --check`
7. `terragrunt hcl validate`
8. provider 비용이 없는 경우에만 `terraform plan` 또는 `terragrunt run plan`
9. apply/destroy를 실행하지 않는 기본 정책
10. AWS 비용 승인 전에는 cloud provider 예제를 실행하지 않는다는 주의

## 요청 예시

### Cilium 랩 생성

```text
AGENTS.md 기준으로 labs/local-cilium 랩을 만들어줘.
kind 클러스터 생성, Cilium 설치, Hubble 활성화, NetworkPolicy 테스트, cleanup 스크립트까지 포함해줘.
```

기대 산출물:

- `labs/local-cilium/README.md`
- `labs/local-cilium/scripts/install.sh`
- `labs/local-cilium/scripts/verify.sh`
- `labs/local-cilium/scripts/cleanup.sh`
- `labs/local-cilium/manifests/echo.yaml`
- `labs/local-cilium/manifests/network-policy.yaml`

### Gateway API 랩 생성

```text
AGENTS.md 기준으로 labs/local-gateway-api 랩을 만들어줘.
Cilium Gateway API를 사용하고 /app-a, /app-b path routing 테스트를 포함해줘.
```

기대 산출물:

- GatewayClass 확인 절차
- Gateway manifest
- HTTPRoute manifest
- app-a/app-b sample deployment
- curl 기반 검증 스크립트

### Karpenter 개념 문서 설계

```text
AGENTS.md 기준으로 docs/karpenter-concepts.md 문서를 설계해줘.
AWS 실행 없이 Karpenter 개념, NodePool, EC2NodeClass, NodeClaim, HPA/KEDA와의 차이를 정리해줘.
```

기대 산출물:

- AWS 비용 제약 문구
- Karpenter가 해결하는 문제
- Cluster Autoscaler와의 차이
- NodePool / EC2NodeClass / NodeClaim 관계
- consolidation과 비용 최적화 개념
- HPA/KEDA와의 역할 비교
- 로컬에서 대체로 실습할 수 있는 주제 연결

### Terraform/Terragrunt 문서 설계

```text
AGENTS.md 기준으로 docs/terraform-terragrunt-local-validation.md 문서를 설계해줘.
AWS 없이 Terraform module, Terragrunt live 구조, HCL 검증 절차를 작성해줘.
```

기대 산출물:

- AWS 미사용 전제
- Terraform module 예시
- `root.hcl` 공통 설정
- environment별 `terragrunt.hcl`
- dependency 예시
- `terragrunt hcl fmt --check` / `terragrunt hcl validate` 검증 절차
- 비용 없는 provider에서만 plan을 실행한다는 조건
- apply/destroy 금지와 비용 승인 조건
