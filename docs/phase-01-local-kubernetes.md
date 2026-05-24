# Phase 1. 로컬 Kubernetes 기본

## 목표

이 Chapter는 로컬 kind 클러스터에서 가장 작은 Kubernetes 배포 루프를 반복하는 실습입니다.

학습 목표:

- kind 클러스터를 생성하고 삭제한다.
- sample HTTP echo 애플리케이션을 배포한다.
- `kubectl wait`로 readiness를 확인한다.
- `kubectl logs`, `kubectl describe`, `kubectl get events`로 기본 상태를 조사한다.
- `kubectl port-forward`로 Service를 로컬에서 호출한다.
- 실습 리소스를 명확한 manifest 단위로 정리한다.

## 아키텍처

```text
localhost:8080
    |
kubectl port-forward
    |
Service/lab-echo -n lab-chapter-01
    |
Deployment/lab-echo
    |
Pod x 2: hashicorp/http-echo:1.0
```

`apps/echo/manifests/`는 다음 리소스를 만든다.

- `Namespace/lab-chapter-01`
- `Deployment/lab-echo`
- `Service/lab-echo`

## 사전 준비

macOS에서 Colima 또는 Docker Desktop 등 Docker runtime이 실행 중이어야 한다.

필요 도구를 확인한다.

```bash
./scripts/install-tools.sh
```

최소 필요 도구:

- `kind`
- `kubectl`
- `docker`
- `kubeconform`

## 설치

로컬 kind 클러스터를 생성한다.

```bash
./scripts/create-kind-cluster.sh
```

현재 context가 생성한 kind 클러스터인지 확인한다.

```bash
kubectl config current-context
kubectl get nodes
```

예상 결과:

- context가 `kind-kubernetes-platform-lab`이다.
- control-plane node와 worker node가 보인다.

## 튜토리얼

manifest를 먼저 검증한다.

```bash
kubeconform -strict -summary apps/echo/manifests/
```

echo 애플리케이션을 배포한다.

```bash
kubectl apply -f apps/echo/manifests/
```

Deployment가 Available 상태가 될 때까지 기다린다.

```bash
kubectl wait --for=condition=Available deployment/lab-echo -n lab-chapter-01 --timeout=120s
```

리소스 상태를 확인한다.

```bash
kubectl get all -n lab-chapter-01
```

로그를 확인한다.

```bash
kubectl logs deployment/lab-echo -n lab-chapter-01
```

Deployment 상세와 관련 이벤트를 확인한다.

```bash
kubectl describe deployment/lab-echo -n lab-chapter-01
kubectl get events -n lab-chapter-01 --sort-by=.lastTimestamp
```

Service를 로컬 포트로 연결한다.

```bash
kubectl port-forward -n lab-chapter-01 service/lab-echo 8080:80
```

다른 터미널에서 호출한다.

```bash
curl http://127.0.0.1:8080
```

예상 응답:

```text
hello from chapter 1
```

## 검증

Chapter 1 완료 기준:

- `kubectl wait`가 `deployment.apps/lab-echo condition met`를 출력한다.
- `kubectl get pods -n lab-chapter-01`에서 Pod가 `Running` 상태다.
- `curl http://127.0.0.1:8080`이 `hello from chapter 1`을 출력한다.
- `kubectl get events -n lab-chapter-01 --sort-by=.lastTimestamp`에서 scheduling, pulling, started 이벤트를 확인할 수 있다.

## 실패 케이스

### Docker runtime이 꺼져 있음

증상:

- `./scripts/create-kind-cluster.sh`가 Docker runtime 오류로 실패한다.

확인:

```bash
docker info
```

조치:

- Colima 또는 Docker Desktop을 시작한 뒤 다시 실행한다.

### Pod가 Pending 상태

확인:

```bash
kubectl describe pod -n lab-chapter-01 -l app.kubernetes.io/name=lab-echo
kubectl get events -n lab-chapter-01 --sort-by=.lastTimestamp
```

주로 image pull, node scheduling, resource 부족 이벤트를 확인한다.

### port-forward 포트 충돌

증상:

- `address already in use` 메시지가 보인다.

조치:

```bash
kubectl port-forward -n lab-chapter-01 service/lab-echo 18080:80
curl http://127.0.0.1:18080
```

## 정리

실습 애플리케이션만 삭제한다.

```bash
kubectl delete -f apps/echo/manifests/
```

클러스터까지 정리하려면 이 저장소가 만든 기본 kind 클러스터만 삭제한다.

```bash
./scripts/delete-kind-cluster.sh
```

## 운영 관점 메모

- `kubectl wait`는 튜토리얼과 CI에서 “배포가 준비됐는지”를 명확히 판단하는 첫 번째 안전장치다.
- `describe`와 `events`는 장애 초기에 가장 먼저 보는 근거다. Pod가 뜨지 않으면 로그보다 이벤트가 더 빠르게 원인을 알려주는 경우가 많다.
- `port-forward`는 로컬 검증에는 편하지만 운영 노출 방식은 아니다. 이후 Chapter에서는 Service, Ingress, Gateway API로 노출 방식을 분리해서 학습한다.
- namespace를 실습마다 분리하면 cleanup 범위가 명확해지고, 다른 랩 리소스를 실수로 건드릴 가능성이 줄어든다.

## 다음 학습 주제

다음 단계는 `labs/local-cilium`에서 Cilium CNI, Hubble, NetworkPolicy를 실습하는 것입니다.
