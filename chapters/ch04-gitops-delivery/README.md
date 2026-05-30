# Chapter 04. GitOps와 점진적 배포

## 목표

Argo CD로 GitOps 배포 흐름을 익히고 Argo Rollouts로 canary와 rollback을 실습한다.

## 학습 대상

- Argo CD
- Argo Rollouts
- Application
- ApplicationSet
- Canary
- Blue/Green
- Rollback

## 기존 자료

- [학습 주제: GitOps와 배포 전략](../../guides/learning-topics.md)
- 예정 실습 경로: `labs/local-argocd`
- 예정 실습 경로: `labs/local-argo-rollouts`
- 예정 phase 문서: `docs/phase-03-gitops-delivery.md`

## 실습 방식

kind 클러스터에 Argo CD와 Argo Rollouts를 설치하고 sample app을 Git 상태와 동기화한다. drift 복구, canary 단계 전환, 실패 버전 rollback을 확인한다.

## 검증 기준

- Argo CD Application이 `Synced`와 `Healthy` 상태다.
- 수동 변경이 Git 상태로 복구된다.
- canary 단계별 replica 또는 traffic 전환을 확인할 수 있다.
- 실패 버전 배포 후 rollback 흐름을 설명할 수 있다.

## 정리 기준

- Argo CD, Argo Rollouts, sample app 리소스를 삭제한다.
- 실습 종료 후 kind 클러스터를 삭제한다.

## 다음 챕터

- [Chapter 05. 정책과 보안](../ch05-policy-security/README.md)
