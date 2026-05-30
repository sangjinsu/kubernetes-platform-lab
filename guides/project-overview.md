# 프로젝트 개요

## 목적

이 저장소는 Kubernetes 플랫폼 엔지니어링 핵심 기술을 작은 튜토리얼 단위로 실습하기 위한 랩입니다.

Codex는 이 문서를 기준으로 다음을 수행한다.

1. 주요 Kubernetes 운영 기술을 작은 튜토리얼 단위로 학습한다.
2. 각 튜토리얼마다 설치, 배포, 검증, 실패 케이스, 정리 과정을 포함한다.
3. 모든 실습 결과는 재현 가능한 스크립트와 문서로 남긴다.
4. 운영 환경에 바로 적용하기보다 로컬 kind/Colima 환경에서 먼저 검증한다.
5. AWS/EKS/NHN Cloud 비용이 발생할 수 있는 실습은 기본 학습 범위에서 제외하고, 필요한 경우 개념/설계 문서로 먼저 다룬다.

## 기본 전제

- 사용자는 Kubernetes, Helm, Terraform, Terragrunt, Argo 계열 도구를 학습 및 운영 관점에서 다룬다.
- 로컬 개발 환경은 macOS + Colima + Docker 런타임을 우선한다.
- 로컬 Kubernetes 실습은 `kind`를 기본으로 한다.
- 클라우드 실습은 비용 제약 때문에 기본적으로 실행하지 않는다.
- Karpenter만 명시적 비용 승인 후 AWS EKS 선택 실습으로 다룰 수 있다.
- NHN Cloud NKS는 Karpenter 실행 대상이 아니라 managed Kubernetes 비용/삭제 비교 대상으로 다룬다.
- 문서와 설명은 기본적으로 한국어로 작성한다.
- 코드, YAML, Helm values, Terraform/Terragrunt 파일은 영어 이름을 사용한다.

## Codex 작업 원칙

Codex는 작업을 시작하기 전에 항상 다음 순서로 진행한다.

1. `AGENTS.md`와 관련 `guides/*.md`를 읽는다.
2. 현재 디렉터리 구조를 확인한다.
3. 기존 파일을 수정하기 전에 의도를 요약한다.
4. 가능한 한 작은 단위의 변경만 수행한다.
5. 튜토리얼마다 실행 가능한 검증 명령을 포함한다.
6. 실습 후 정리 명령을 반드시 제공한다.
7. 민감 정보, kubeconfig, AWS credential, access token은 절대 커밋하지 않는다.
8. AWS credential, AWS CLI 실행, EKS 생성, AWS provider 기반 Terraform/Terragrunt 실행은 기본 학습 경로에 포함하지 않는다.
9. Karpenter AWS EKS 실습은 별도 비용 승인 후에만 제한적으로 문서화한다.
10. `terraform apply`, `terragrunt run apply`, `kubectl delete` 기반 cluster-wide resource 삭제, 실제 AWS/NHN Cloud 리소스 생성 명령은 사용자의 명시적 비용 승인 없이는 실행 대상으로 작성하지 않는다.
11. 설명만 필요한 경우에는 코드를 과도하게 생성하지 않는다.
