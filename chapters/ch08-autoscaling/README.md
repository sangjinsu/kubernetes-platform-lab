# Chapter 08. 오토스케일링

## 목표

HPA와 KEDA의 차이를 실습으로 이해하고 workload scale-out/scale-in 흐름을 확인한다.

## 학습 대상

- HPA
- VPA 개념
- KEDA
- Metrics Server
- custom metrics
- event-driven autoscaling

## 기존 자료

- [학습 주제: Autoscaling](../../guides/learning-topics.md)
- 예정 실습 경로: `labs/local-hpa`
- 예정 실습 경로: `labs/local-keda`
- 예정 phase 문서: `docs/phase-06-autoscaling.md`

## 실습 방식

kind 클러스터에 Metrics Server를 설치하고 CPU 부하 기반 HPA를 실습한다. KEDA는 로컬 Redis 또는 HTTP add-on 기반으로 이벤트가 없을 때 scale-to-zero 흐름을 확인한다.

## 검증 기준

- 부하 증가 시 replica가 증가한다.
- 부하 감소 시 replica가 감소한다.
- KEDA 실습에서 이벤트가 없을 때 0 또는 최소 replica로 줄어든다.
- Karpenter가 해결하는 node provisioning 문제와 HPA/KEDA의 replica scaling 문제를 구분할 수 있다.

## 정리 기준

- scaler backend, workload, metric 리소스를 삭제한다.
- 실습 종료 후 kind 클러스터를 삭제한다.

## 다음 챕터

- [Chapter 09. Terraform/Terragrunt](../ch09-terraform-terragrunt/README.md)
