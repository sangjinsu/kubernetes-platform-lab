# AGENTS.md

이 저장소는 Kubernetes 플랫폼 엔지니어링 핵심 기술을 로컬 kind/Colima 환경에서 실습 중심으로 학습하기 위한 랩입니다.

세부 지침은 아래 가이드를 함께 읽고 따른다.

@guides/project-overview.md
@guides/learning-topics.md
@guides/lab-standards.md
@guides/testing-policy.md
@guides/roadmap.md
@guides/safety.md

## 핵심 원칙

- 모든 설명과 문서는 한국어로 작성한다.
- 코드, YAML, Helm values, Terraform/Terragrunt 리소스 이름은 영어를 사용한다.
- 작업 전 `AGENTS.md`와 관련 `guides/*.md`를 읽고 현재 디렉터리 구조를 확인한다.
- 기존 사용자 변경을 되돌리지 않는다.
- 실습은 운영 환경보다 로컬 kind/Colima 검증을 우선한다.
- 민감 정보, kubeconfig, AWS credential, access token은 만들거나 저장하지 않는다.
- 비용 문제로 AWS/EKS는 현재 학습 환경에서 사용하지 않는다.
- AWS CLI, EKS, Karpenter, AWS provider 기반 Terraform/Terragrunt 실행은 기본 학습 경로에 포함하지 않는다.
- 사용자의 명시적 비용 승인 없이는 `terraform apply`, `terragrunt run apply`, 실제 AWS 리소스 생성, cluster-wide 삭제 명령을 실행하지 않는다.
- 각 랩은 설치, 튜토리얼, 검증, 실패 케이스, 정리 절차를 포함한다.
- manifest나 chart를 추가할 때 가능한 검증 명령을 함께 제공한다.
