# 학습 주제

## 1. 로컬 Kubernetes 기반

학습 대상:

- kind
- kubectl
- Helm
- Kustomize
- kubeconform
- kubectl wait
- kubectl debug
- kubectl events

학습 목표:

- 로컬 클러스터를 빠르게 만들고 삭제할 수 있다.
- YAML manifest를 검증할 수 있다.
- Helm chart를 렌더링하고 검증할 수 있다.
- 장애 상황에서 기본적인 kubectl 디버깅을 수행할 수 있다.

필수 실습:

- kind 클러스터 생성
- 테스트용 nginx 배포
- Service, Ingress 또는 Gateway로 노출
- `kubectl wait`로 readiness 검증
- `kubectl logs`, `kubectl describe`, `kubectl events` 확인
- 리소스 정리

## 2. Cilium

학습 대상:

- Cilium CNI
- eBPF datapath
- Cilium NetworkPolicy
- Hubble
- Cilium Gateway API
- Cilium Service Mesh 기본 개념
- L3/L4/L7 정책

학습 목표:

- Cilium을 kind 클러스터에 설치할 수 있다.
- Pod 간 통신을 Hubble로 관찰할 수 있다.
- NetworkPolicy로 허용/차단 정책을 적용할 수 있다.
- Gateway API와 함께 HTTPRoute를 구성할 수 있다.

필수 실습:

- kind 클러스터 생성
- Cilium Helm 설치
- Cilium 상태 확인
- Hubble 활성화
- `curl` 테스트용 echo 애플리케이션 배포
- default deny 정책 적용
- 특정 namespace/app만 허용하는 정책 적용
- Hubble flow 확인
- GatewayClass, Gateway, HTTPRoute 실습

검증 기준:

- `cilium status`가 정상이어야 한다.
- 테스트 Pod에서 허용된 서비스로만 통신 가능해야 한다.
- 차단된 통신은 실패해야 한다.
- Hubble에서 flow를 확인할 수 있어야 한다.
- Gateway API 경로 라우팅이 동작해야 한다.

## 3. Gateway API

학습 대상:

- GatewayClass
- Gateway
- HTTPRoute
- ReferenceGrant
- TLSRoute 개념
- Ingress와 Gateway API 차이

학습 목표:

- Ingress보다 역할이 명확한 라우팅 모델을 이해한다.
- infra owner와 app owner 관점의 리소스 분리를 이해한다.
- Cilium 또는 Envoy Gateway 기반으로 HTTPRoute를 구성한다.

필수 실습:

- GatewayClass 확인
- Gateway 생성
- 여러 Service에 대한 path 기반 HTTPRoute 구성
- 잘못된 backendRef 실패 케이스 확인
- cross namespace route를 위한 ReferenceGrant 실습

검증 기준:

- `/app-a`, `/app-b` 경로가 서로 다른 서비스로 라우팅되어야 한다.
- 잘못된 route는 status condition으로 실패 원인을 확인할 수 있어야 한다.

## 4. Karpenter

학습 대상:

- Karpenter
- Terraform
- Terragrunt
- NodePool
- EC2NodeClass
- NodeClaim
- consolidation
- Spot / On-Demand 혼합
- Cluster Autoscaler와의 차이
- EKS Managed Node Group과의 관계

학습 목표:

- pending pod를 기반으로 필요한 노드를 자동 생성하는 흐름을 이해한다.
- NodePool 요구사항으로 인스턴스 타입, 용량 타입, 아키텍처를 제어한다.
- consolidation으로 비용 최적화되는 흐름을 관찰한다.

주의:

- Karpenter 실습은 AWS 비용이 발생할 수 있다.
- 이 저장소에서는 Karpenter 실습을 `labs/cloud-aws-karpenter`에만 작성한다.
- 기본 상태에서는 `terraform plan`, `terragrunt run plan` 또는 manifest 작성까지만 수행한다.
- 실제 `terraform apply`, `terragrunt run apply`와 부하 테스트는 명시적 요청이 있을 때만 안내한다.

필수 실습:

- EKS 클러스터 전제 조건 문서화
- Terraform/Terragrunt 디렉터리 구조 문서화
- Karpenter Helm chart 설치 manifest 작성
- NodePool 작성
- EC2NodeClass 작성
- pending pod를 만드는 inflate deployment 작성
- NodeClaim 생성 확인
- consolidation 설정 확인
- 리소스 정리 절차 작성

검증 기준:

- pending pod가 생기면 NodeClaim이 생성되어야 한다.
- NodePool 조건에 맞는 노드가 생성되어야 한다.
- scale down 후 consolidation 이벤트를 확인할 수 있어야 한다.
- 정리 절차로 노드와 워크로드가 제거되어야 한다.

## 4-1. Terraform/Terragrunt 기반 IaC 운영

학습 대상:

- Terraform module 구조
- Terragrunt
- `terragrunt.hcl`
- `terragrunt.stack.hcl`
- root configuration
- dependency/dependencies 구성
- remote state 설계
- environment별 plan workflow

학습 목표:

- Terraform module과 environment 구성을 분리하는 이유를 이해한다.
- Terragrunt로 반복되는 backend, provider, input 구성을 줄이는 방식을 이해한다.
- 여러 unit 또는 stack에 대해 plan 순서와 의존성을 확인할 수 있다.
- cloud 랩에서 apply 이전에 어떤 변경이 발생하는지 검토하는 습관을 만든다.

주의:

- Terragrunt는 Terraform/OpenTofu 실행을 orchestration하므로 AWS 비용 발생 가능성이 있다.
- 이 저장소의 기본 Terragrunt 실습은 `plan`과 HCL 검증 중심으로 작성한다.
- 사용자의 명시적 요청 없이 `terragrunt run apply`, `terragrunt run --all apply`, `terragrunt run destroy`, `terragrunt run --all destroy`를 실행 대상으로 작성하지 않는다.

필수 실습:

- `root.hcl` 또는 공통 root configuration 설계
- environment별 `terragrunt.hcl` 작성
- module source와 inputs 분리
- dependency 또는 dependencies를 사용한 unit 관계 문서화
- `terragrunt hcl fmt` 실행
- `terragrunt hcl validate` 실행
- `terragrunt run plan` 또는 `terragrunt run --all plan`으로 변경사항 확인

검증 기준:

- Terragrunt HCL 파일이 formatting과 validation을 통과해야 한다.
- plan 결과에서 생성/변경/삭제 대상과 비용 영향 가능성을 설명할 수 있어야 한다.
- dependency가 있는 unit은 순서와 입력 관계를 문서로 확인할 수 있어야 한다.
- apply/destroy 명령은 README에서 명시적 주의 문구와 별도 승인 조건을 가져야 한다.

## 5. Autoscaling

학습 대상:

- HPA
- VPA
- KEDA
- Metrics Server
- custom metrics
- event-driven autoscaling

학습 목표:

- CPU/Memory 기반 스케일링과 이벤트 기반 스케일링의 차이를 이해한다.
- HPA와 KEDA가 어떤 방식으로 metric을 사용하는지 이해한다.
- 게임 서버나 이벤트 처리 워커에서 어떤 스케일링 전략을 선택할지 판단한다.

필수 실습:

- Metrics Server 설치
- CPU 부하 기반 HPA 실습
- KEDA 설치
- Redis queue 또는 HTTP add-on 기반 scale-to-zero 실습
- scaling event 확인

검증 기준:

- 부하 증가 시 replica가 증가해야 한다.
- 부하 감소 시 replica가 감소해야 한다.
- KEDA 실습에서는 이벤트가 없을 때 0 또는 최소 replica로 줄어들어야 한다.

## 6. GitOps와 배포 전략

학습 대상:

- Argo CD
- Argo Rollouts
- Helm
- Kustomize
- Application
- ApplicationSet
- Canary
- Blue/Green
- Rollback

학습 목표:

- Git 저장소를 단일 진실 공급원으로 사용하는 GitOps 흐름을 이해한다.
- Argo CD sync, diff, prune, self-heal을 실습한다.
- Argo Rollouts로 canary 배포와 rollback을 실습한다.

필수 실습:

- Argo CD 설치
- sample app Application 작성
- Git 변경, Sync, 배포 확인
- drift 발생 후 self-heal 확인
- Argo Rollouts 설치
- canary 배포
- 실패한 버전 배포 후 rollback

검증 기준:

- Argo CD Application이 Synced/Healthy 상태여야 한다.
- 수동 변경이 Git 상태로 복구되어야 한다.
- canary 단계별 트래픽 또는 replica 전환을 확인할 수 있어야 한다.

## 7. 정책과 보안

학습 대상:

- Kyverno
- OPA Gatekeeper 비교
- Pod Security Standards
- image policy
- resource request/limit policy
- namespace label policy
- Trivy
- SBOM 기본 개념

학습 목표:

- Kubernetes admission control 기반 정책을 이해한다.
- 운영에서 자주 필요한 정책을 YAML로 작성할 수 있다.
- 정책 위반 케이스를 테스트할 수 있다.

필수 실습:

- Kyverno 설치
- require labels 정책 작성
- disallow latest image 정책 작성
- require resource requests/limits 정책 작성
- 정책 위반 manifest 적용 후 실패 확인
- 정책 통과 manifest 적용 후 성공 확인
- `kyverno test` 작성

검증 기준:

- 위반 리소스는 admission 단계에서 거부되어야 한다.
- 정상 리소스는 생성되어야 한다.
- 정책 테스트가 자동화되어야 한다.

## 8. Secret과 인증서 관리

학습 대상:

- External Secrets Operator
- AWS Secrets Manager 연동 개념
- fake provider 또는 local provider
- cert-manager
- SelfSigned Issuer
- ACME / Let's Encrypt 개념
- trust-manager 개념

학습 목표:

- 애플리케이션이 직접 외부 secret store에 접근하지 않아도 되는 구조를 이해한다.
- Kubernetes Secret을 외부 시스템과 동기화하는 흐름을 이해한다.
- 인증서 발급과 갱신을 Kubernetes 리소스로 관리하는 방식을 이해한다.

필수 실습:

- External Secrets Operator 설치
- fake provider 기반 ExternalSecret 작성
- Secret 생성 확인
- cert-manager 설치
- SelfSigned Issuer 작성
- Certificate 작성
- Secret에 TLS 인증서 생성 확인

검증 기준:

- ExternalSecret이 Kubernetes Secret으로 동기화되어야 한다.
- Certificate 리소스가 Ready 상태가 되어야 한다.
- 생성된 TLS Secret을 확인할 수 있어야 한다.

## 9. Observability

학습 대상:

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

학습 목표:

- metric, log, trace의 차이를 이해한다.
- Prometheus Operator 방식의 모니터링 리소스를 이해한다.
- 애플리케이션 metric을 ServiceMonitor로 수집할 수 있다.
- OpenTelemetry Collector를 통해 trace/metric/log 파이프라인을 구성할 수 있다.

필수 실습:

- kube-prometheus-stack 설치
- sample app metric endpoint 노출
- ServiceMonitor 작성
- Prometheus target 확인
- Grafana dashboard 접속
- Loki 설치
- sample app log 조회
- OpenTelemetry Collector 설치
- trace exporter 구성

검증 기준:

- Prometheus target이 UP 상태여야 한다.
- Grafana에서 Kubernetes 기본 dashboard를 볼 수 있어야 한다.
- Loki에서 sample app 로그를 조회할 수 있어야 한다.
- OpenTelemetry Collector pod가 정상 기동되어야 한다.

## 10. 백업과 복구

학습 대상:

- Velero
- VolumeSnapshot
- namespace backup
- restore
- migration
- disaster recovery 기본 개념

학습 목표:

- Kubernetes 리소스와 PV 백업 방식을 이해한다.
- namespace 단위 백업과 복구를 실습한다.
- 운영 환경에서 백업 정책을 어떻게 설계할지 판단한다.

필수 실습:

- Velero 설치 전략 문서화
- MinIO 또는 local object storage 기반 테스트 구성
- namespace 백업
- namespace 삭제
- restore 수행
- 복구된 리소스 확인

검증 기준:

- 백업이 Completed 상태여야 한다.
- 삭제된 namespace가 restore 후 복구되어야 한다.
- PVC가 포함된 경우 데이터 보존 여부를 확인해야 한다.
