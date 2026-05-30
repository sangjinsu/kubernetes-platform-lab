# Chapter 09. Terraform/Terragrunt

## 목표

cloud provider 없이 Terraform module과 Terragrunt live 구조를 학습하고 static validation 흐름을 만든다.

## 학습 대상

- Terraform module 구조
- Terragrunt
- `terragrunt.hcl`
- `terragrunt.stack.hcl`
- root configuration
- dependency/dependencies 구성
- local backend
- environment별 validation workflow

## 기존 자료

- [학습 주제: Terraform/Terragrunt 기반 IaC 운영](../../guides/learning-topics.md)
- 예정 문서: `docs/terraform-terragrunt-local-validation.md`
- 예정 예제 경로: `examples/terraform-terragrunt`

## 실습 방식

AWS/EKS를 사용하지 않는다. 비용 없는 provider 또는 static validation 중심으로 module과 live 구조를 만들고 `terragrunt hcl fmt --check`, `terragrunt hcl validate`를 수행한다.

## 검증 기준

- Terragrunt HCL 파일이 formatting과 validation을 통과한다.
- module과 live 디렉터리의 역할을 설명할 수 있다.
- dependency 구성이 필요한 이유를 설명할 수 있다.
- provider 비용이 없는 경우에만 plan을 실행해야 하는 이유를 설명할 수 있다.

## 정리 기준

- 생성된 local state, cache, temporary output을 정리한다.
- AWS provider, credential, apply/destroy 흐름은 비용 승인 전 작성하지 않는다.

## 다음 챕터

- [Chapter 10. Karpenter](../ch10-karpenter/README.md)
