# Chapter 02. Cilium과 네트워크 정책

## 목표

Cilium CNI, Hubble, NetworkPolicy를 로컬 kind 환경에서 실습한다.

## 학습 대상

- Cilium CNI
- eBPF datapath
- Cilium NetworkPolicy
- Hubble
- L3/L4/L7 정책

## 기존 자료

- [학습 주제: Cilium](../../guides/learning-topics.md)
- 예정 실습 경로: `labs/local-cilium`
- 예정 phase 문서: `docs/phase-02-networking.md`

## 실습 방식

kind 클러스터에 Cilium을 Helm으로 설치하고, echo 애플리케이션과 curl Pod를 사용해 허용/차단 통신을 확인한다. Hubble로 flow를 관찰한다.

## 검증 기준

- `cilium status`가 정상이다.
- 허용된 namespace/app 조합만 통신할 수 있다.
- 차단된 통신은 실패한다.
- Hubble에서 허용/차단 flow를 확인할 수 있다.

## 정리 기준

- Cilium 실습 namespace와 테스트 리소스를 삭제한다.
- 실습 종료 후 kind 클러스터를 삭제한다.

## 다음 챕터

- [Chapter 03. Gateway API 라우팅](../ch03-gateway-api/README.md)
