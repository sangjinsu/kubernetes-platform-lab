# apps

실습용 sample application을 보관하는 디렉터리입니다.

초기 우선순위:

- `echo`: 네트워크, Gateway API, observability 실습용 HTTP echo 애플리케이션
- `sample-api`: GitOps, rollout, metric 노출 실습용 API 애플리케이션

현재 제공되는 애플리케이션:

- `echo`: Chapter 1에서 kind 클러스터 배포 기본 루프를 검증하는 HTTP echo 애플리케이션

실제 애플리케이션을 추가할 때는 실행 방법, container image, Kubernetes manifest 위치, 검증 명령을 README에 함께 기록한다.
