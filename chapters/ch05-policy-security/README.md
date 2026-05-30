# Chapter 05. 정책과 보안

## 목표

Kubernetes admission control 기반 정책을 작성하고 위반/통과 케이스를 검증한다.

## 학습 대상

- Kyverno
- OPA Gatekeeper 비교
- Pod Security Standards
- image policy
- resource request/limit policy
- namespace label policy
- Trivy
- SBOM 기본 개념

## 기존 자료

- [학습 주제: 정책과 보안](../../guides/learning-topics.md)
- 예정 실습 경로: `labs/local-kyverno`
- 예정 phase 문서: `docs/phase-04-security.md`

## 실습 방식

kind 클러스터에 Kyverno를 설치하고 label, image tag, resource request/limit 정책을 작성한다. 정책 위반 manifest와 통과 manifest를 함께 테스트한다.

## 검증 기준

- 위반 리소스는 admission 단계에서 거부된다.
- 정상 리소스는 생성된다.
- `kyverno test`로 정책 테스트를 자동화할 수 있다.
- 운영 환경에 필요한 기본 정책 목록을 설명할 수 있다.

## 정리 기준

- Kyverno 정책과 테스트 리소스를 삭제한다.
- 실습 종료 후 kind 클러스터를 삭제한다.

## 다음 챕터

- [Chapter 06. Secret과 인증서](../ch06-secrets-certificates/README.md)
