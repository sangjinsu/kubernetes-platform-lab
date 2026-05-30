# Chapter 07. 관측성

## 목표

metric, log, trace의 차이를 이해하고 Kubernetes 관측성 stack의 기본 흐름을 구성한다.

## 학습 대상

- kube-prometheus-stack
- Prometheus Operator
- ServiceMonitor
- PodMonitor
- Grafana
- Alertmanager
- Loki
- Promtail 또는 Alloy
- Tempo
- OpenTelemetry Operator
- OpenTelemetry Collector

## 기존 자료

- [학습 주제: Observability](../../guides/learning-topics.md)
- 예정 실습 경로: `labs/local-observability`
- 예정 phase 문서: `docs/phase-05-observability.md`

## 실습 방식

kind 클러스터에 metric/log/trace 구성 요소를 작은 단위로 설치한다. sample app metric endpoint, log 조회, OpenTelemetry Collector pipeline을 순서대로 확인한다.

## 검증 기준

- Prometheus target이 `UP` 상태다.
- Grafana에서 Kubernetes 기본 dashboard를 볼 수 있다.
- Loki에서 sample app 로그를 조회할 수 있다.
- OpenTelemetry Collector Pod가 정상 기동한다.
- 장기 저장소를 cloud object storage로 옮길 때 비용이 발생하는 이유를 설명할 수 있다.

## 정리 기준

- observability namespace와 PVC를 명확히 삭제한다.
- 실습 종료 후 kind 클러스터를 삭제한다.

## 다음 챕터

- [Chapter 08. 오토스케일링](../ch08-autoscaling/README.md)
