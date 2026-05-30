# Chapter 01. 로컬 Kubernetes 기본

## 목표

kind 클러스터에서 가장 작은 Kubernetes 배포 루프를 익힌다.

## 학습 대상

- kind
- kubectl
- kubeconform
- `kubectl wait`
- `kubectl logs`
- `kubectl describe`
- `kubectl get events`
- `kubectl port-forward`

## 기존 자료

- [Phase 1. 로컬 Kubernetes 기본](../../docs/phase-01-local-kubernetes.md)
- [echo 앱](../../apps/echo/README.md)
- [echo manifest](../../apps/echo/manifests/)
- [클러스터 생성 스크립트](../../scripts/create-kind-cluster.sh)
- [클러스터 삭제 스크립트](../../scripts/delete-kind-cluster.sh)

## 실습 방식

로컬 kind 클러스터를 만들고 `apps/echo/manifests/`를 배포한다. Service는 `kubectl port-forward`로 호출한다.

## 검증 기준

- `kubeconform -strict -summary apps/echo/manifests/`가 성공한다.
- `kubectl wait --for=condition=Available deployment/lab-echo -n lab-chapter-01 --timeout=120s`가 성공한다.
- `curl http://127.0.0.1:8080`이 `hello from chapter 1`을 출력한다.
- event, describe, logs로 기본 장애 조사 루프를 설명할 수 있다.

## 정리 기준

- `kubectl delete -f apps/echo/manifests/`로 앱 리소스를 정리한다.
- 실습 종료 후 `./scripts/delete-kind-cluster.sh`로 kind 클러스터를 삭제한다.

## 다음 챕터

- [Chapter 02. Cilium과 네트워크 정책](../ch02-cilium-networking/README.md)
