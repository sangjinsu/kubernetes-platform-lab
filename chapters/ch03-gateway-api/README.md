# Chapter 03. Gateway API 라우팅

## 목표

Gateway API의 역할 분리 모델을 이해하고 HTTPRoute 기반 path routing을 실습한다.

## 학습 대상

- GatewayClass
- Gateway
- HTTPRoute
- ReferenceGrant
- Ingress와 Gateway API 차이

## 기존 자료

- [학습 주제: Gateway API](../../guides/learning-topics.md)
- 예정 실습 경로: `labs/local-gateway-api`
- 예정 phase 문서: `docs/phase-02-networking.md`

## 실습 방식

Cilium Gateway API 또는 Envoy Gateway를 로컬 kind 클러스터에 설치하고 `/app-a`, `/app-b` path routing을 구성한다. 잘못된 backendRef와 cross namespace route 조건도 확인한다.

## 검증 기준

- `/app-a`, `/app-b`가 서로 다른 Service로 라우팅된다.
- 잘못된 route는 status condition으로 실패 원인을 확인할 수 있다.
- ReferenceGrant가 필요한 cross namespace 흐름을 설명할 수 있다.

## 정리 기준

- Gateway, HTTPRoute, sample app 리소스를 삭제한다.
- 실습 종료 후 kind 클러스터를 삭제한다.

## 다음 챕터

- [Chapter 04. GitOps와 점진적 배포](../ch04-gitops-delivery/README.md)
