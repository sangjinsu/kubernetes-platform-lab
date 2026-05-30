# Chapter 06. Secret과 인증서

## 목표

External Secrets와 cert-manager로 secret 동기화와 인증서 발급 흐름을 이해한다.

## 학습 대상

- External Secrets Operator
- fake provider 또는 local provider
- AWS Secrets Manager 연동 개념
- cert-manager
- SelfSigned Issuer
- ACME / Let's Encrypt 개념
- trust-manager 개념

## 기존 자료

- [학습 주제: Secret과 인증서 관리](../../guides/learning-topics.md)
- 예정 실습 경로: `labs/local-external-secrets`
- 예정 실습 경로: `labs/local-cert-manager`
- 예정 phase 문서: `docs/phase-04-security.md`

## 실습 방식

External Secrets는 fake provider 또는 local provider로 실습한다. cert-manager는 SelfSigned Issuer와 Certificate로 TLS Secret 생성까지 확인한다. AWS Secrets Manager와 ACME DNS01은 비용/권한이 필요한 provider 선택형 주제로 문서에서만 다룬다.

## 검증 기준

- ExternalSecret이 Kubernetes Secret으로 동기화된다.
- Certificate 리소스가 `Ready` 상태가 된다.
- TLS Secret이 생성된다.
- provider 선택 시 비용과 권한 경계를 설명할 수 있다.

## 정리 기준

- ExternalSecret, Secret, Issuer, Certificate 리소스를 삭제한다.
- 실습 종료 후 kind 클러스터를 삭제한다.

## 다음 챕터

- [Chapter 07. 관측성](../ch07-observability/README.md)
