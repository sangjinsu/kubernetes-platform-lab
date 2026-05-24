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
│   ├── local-keda
│   ├── cloud-aws-terraform-terragrunt
│   └── cloud-aws-karpenter
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
- Terraform은 module과 variable을 명확히 분리한다.
- Terragrunt는 공통 설정과 environment별 unit을 분리하고, 기본 검증은 `plan` 중심으로 작성한다.
- README에는 실행 순서와 예상 결과를 함께 적는다.

## Terragrunt 랩 표준 구성

Terragrunt를 사용하는 `labs/cloud-*` 디렉터리는 다음 구조를 우선한다.

```text
labs/cloud-aws-example
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

Terragrunt 랩 README는 다음 내용을 반드시 포함한다.

1. 비용 발생 가능성
2. AWS/EKS 사전 조건
3. module과 live 디렉터리 역할
4. `terragrunt.hcl`과 `root.hcl` 관계
5. dependency 구성
6. `terragrunt hcl fmt` 또는 CI 검증용 `terragrunt hcl fmt --check`
7. `terragrunt hcl validate`
8. `terragrunt run plan` 또는 `terragrunt run --all plan`
9. apply/destroy를 실행하지 않는 기본 정책
10. 명시적 승인 후 정리 절차

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

### Karpenter 랩 설계

```text
AGENTS.md 기준으로 labs/cloud-aws-karpenter 랩을 설계해줘.
실제 apply는 하지 않고 Terraform, Helm values, NodePool, EC2NodeClass, 검증 절차만 작성해줘.
```

기대 산출물:

- 비용 주의 문구
- EKS 사전 조건
- Terraform 변수 예시
- Karpenter 설치 절차
- NodePool / EC2NodeClass manifest
- inflate deployment
- NodeClaim 검증 명령
- cleanup 순서

### Terraform/Terragrunt 랩 설계

```text
AGENTS.md 기준으로 labs/cloud-aws-terraform-terragrunt 랩을 설계해줘.
실제 apply는 하지 않고 Terraform module, Terragrunt live 구조, HCL 검증, plan 절차만 작성해줘.
```

기대 산출물:

- 비용 주의 문구
- Terraform module 예시
- `root.hcl` 공통 설정
- environment별 `terragrunt.hcl`
- dependency 예시
- `terragrunt hcl fmt --check` / `terragrunt hcl validate` 검증 절차
- `terragrunt run plan` 또는 `terragrunt run --all plan` 절차
- apply/destroy 금지와 승인 조건
