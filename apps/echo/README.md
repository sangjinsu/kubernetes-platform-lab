# echo

Chapter 1과 이후 네트워크/관측성 랩에서 재사용하는 가장 작은 HTTP echo 애플리케이션입니다.

## 구성

- namespace: `lab-chapter-01`
- deployment: `lab-echo`
- service: `lab-echo`
- image: `hashicorp/http-echo:1.0`
- container port: `5678`
- service port: `80`

## 배포

```bash
kubectl apply -f apps/echo/manifests/
kubectl wait --for=condition=Available deployment/lab-echo -n lab-chapter-01 --timeout=120s
```

## 확인

```bash
kubectl get all -n lab-chapter-01
kubectl logs deployment/lab-echo -n lab-chapter-01
kubectl port-forward -n lab-chapter-01 service/lab-echo 8080:80
```

다른 터미널에서 확인한다.

```bash
curl http://127.0.0.1:8080
```

## 정리

```bash
kubectl delete -f apps/echo/manifests/
```
