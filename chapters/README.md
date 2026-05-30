# Chapters

이 디렉터리는 학습 순서대로 따라가기 위한 챕터별 진입점입니다.

기존 `docs/`, `labs/`, `apps/`, `tests/` 자산은 이동하지 않습니다. 각 챕터 README에서 관련 문서와 실습 경로를 연결합니다.

## 진행 원칙

- 로컬 실습은 kind/Colima 클러스터를 만들고 실습 후 삭제한다.
- 각 챕터는 목표, 학습 대상, 기존 자료, 실습 방식, 검증 기준, 정리 기준을 포함한다.
- cloud provider가 필요한 주제는 비용 영향과 대체 로컬 학습 경로를 먼저 확인한다.
- Karpenter만 명시적 비용 승인 후 AWS EKS 선택 실습으로 다룰 수 있다.

## 챕터 목록

| Chapter | 주제 | 기본 실행 위치 |
| --- | --- | --- |
| [Chapter 01](ch01-local-kubernetes/README.md) | 로컬 Kubernetes 기본 | kind |
| [Chapter 02](ch02-cilium-networking/README.md) | Cilium과 네트워크 정책 | kind |
| [Chapter 03](ch03-gateway-api/README.md) | Gateway API 라우팅 | kind |
| [Chapter 04](ch04-gitops-delivery/README.md) | GitOps와 점진적 배포 | kind |
| [Chapter 05](ch05-policy-security/README.md) | 정책과 보안 | kind |
| [Chapter 06](ch06-secrets-certificates/README.md) | Secret과 인증서 | kind |
| [Chapter 07](ch07-observability/README.md) | 관측성 | kind |
| [Chapter 08](ch08-autoscaling/README.md) | 오토스케일링 | kind |
| [Chapter 09](ch09-terraform-terragrunt/README.md) | Terraform/Terragrunt | local validation |
| [Chapter 10](ch10-karpenter/README.md) | Karpenter | 문서 학습, 선택적 AWS EKS |

## 권장 루프

1. 챕터 README에서 목표와 기존 자료를 확인한다.
2. 로컬 실습이면 `./scripts/create-kind-cluster.sh`로 클러스터를 만든다.
3. 챕터의 튜토리얼과 검증 기준을 수행한다.
4. 실습 리소스를 정리한다.
5. 로컬 실습이 끝나면 `./scripts/delete-kind-cluster.sh`로 클러스터를 삭제한다.
