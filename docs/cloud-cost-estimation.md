# NHN Cloud와 AWS Kubernetes 비용 측정

이 문서는 이 저장소의 로컬 Kubernetes 학습 구성을 클라우드 managed Kubernetes로 옮긴다고 가정했을 때의 최소 월 비용을 비교한다.

실제 NHN Cloud/AWS 리소스를 생성하지 않는다. 비용 산정은 공개 요금표와 AWS Price List API를 기준으로 한 문서 계산이며, 계정 할인, 약정 할인, 세금, 환율, 크레딧은 반영하지 않는다.

## 기준 환경

가격 확인일: 2026-05-30

| 항목 | 기준값 |
| --- | --- |
| 목적 | 최소 학습 클러스터 비용 비교 |
| 월 사용 시간 | 730시간 |
| Kubernetes cluster | 1개 |
| Worker node | 3대 |
| Worker node 크기 | 2 vCPU / 4GB급 |
| Worker storage | 노드당 30GB, 총 90GB |
| 실행 범위 | 비용 산정 문서만 작성, 실제 apply/create 없음 |

## Terragrunt 사용 시 비용 경계

Terragrunt 자체가 클라우드 환경을 요구하지는 않는다. Terragrunt는 Terraform/OpenTofu 실행을 여러 environment와 unit 단위로 정리하고 orchestration하는 도구다. 따라서 이 저장소에서는 다음 두 단계를 분리해서 본다.

| 단계 | 클라우드 필요 여부 | 이 저장소의 기본 학습 범위 |
| --- | --- | --- |
| Terragrunt 구조 학습 | 필요 없음 | `root.hcl`, `terragrunt.hcl`, dependency, input, local backend, formatting, validation |
| 실제 cloud cluster 관리 | 필요함 | 비용 승인 전 기본 범위에서 제외 |

비용 없는 학습은 local backend 또는 cloud provider가 없는 예제로 Terragrunt 파일 구조를 검증하는 데 집중한다. 반대로 Terragrunt로 EKS/NKS, VPC, subnet, node group, block storage를 실제로 만들면 provider가 cloud API를 호출하므로 클라우드 계정, state 관리, 권한, 비용이 모두 필요하다.

운영 관점에서는 Terragrunt가 비용을 만드는 것이 아니라 Terragrunt가 실행하는 Terraform/OpenTofu provider와 resource가 비용을 만든다. 이 차이를 문서와 예제에서 명확히 분리해야 한다.

## 기술별 provider와 비용 분류

이 프로젝트의 기술은 “클라우드 없이 로컬에서 학습 가능한 기술”, “provider 선택에 따라 비용이 달라지는 기술”, “실제 효과 확인에 클라우드가 필요한 기술”로 나눈다.

| 구분 | 기술 | Provider 필요 여부 | 비용 발생 지점 | 이 저장소의 기본 학습 경로 |
| --- | --- | --- | --- | --- |
| 로컬 가능 | kind, kubectl, Helm, Kustomize, kubeconform | cloud provider 불필요 | 로컬 CPU/메모리/디스크만 사용 | Colima/Docker 위 kind cluster 생성/삭제 |
| 로컬 가능 | Cilium CNI, Hubble, Cilium NetworkPolicy | cloud provider 불필요 | LoadBalancer를 실제 cloud로 만들 때만 별도 비용 | kind에 Cilium Helm 설치, Hubble flow와 NetworkPolicy 검증 |
| 로컬 가능 | Gateway API, HTTPRoute, ReferenceGrant | 구현체 필요, cloud provider는 선택 | cloud Load Balancer 사용 시 LB/IP 비용 | Cilium Gateway API 또는 Envoy Gateway를 로컬에서 NodePort/host network 중심으로 실습 |
| 로컬 가능 | HPA, Metrics Server | cloud provider 불필요 | worker node가 cloud일 때만 node 비용 | kind에서 CPU 부하와 replica 변화를 검증 |
| 로컬 가능 | KEDA local scaler, Redis scaler, HTTP add-on | scaler backend 필요, cloud provider는 선택 | Redis/queue/backend를 managed service로 쓰면 비용 | 로컬 Redis 또는 HTTP add-on으로 scale-to-zero 실습 |
| 로컬 가능 | Argo CD, Argo Rollouts | cloud provider 불필요 | 외부 LB, managed Git, long-running cluster 비용 | kind에서 GitOps sync, drift 복구, canary/rollback 실습 |
| 로컬 가능 | Kyverno, Pod Security Standards, policy test | cloud provider 불필요 | cluster가 cloud일 때 admission controller 상시 실행 비용 | kind에서 정책 위반/통과 manifest와 `kyverno test` 검증 |
| 로컬 가능 | cert-manager SelfSigned, CA issuer | cloud provider 불필요 | 없음. 단, production PKI 운영은 별도 설계 필요 | SelfSigned Issuer와 Certificate로 TLS Secret 생성 확인 |
| 로컬 가능 | OpenTelemetry Operator, OpenTelemetry Collector | cloud provider 불필요 | exporter를 cloud APM으로 보내면 수집/저장 비용 | 로컬 Collector와 sample exporter 중심으로 pipeline 학습 |
| Provider 선택형 | External Secrets Operator | secret store provider 필요 | AWS Secrets Manager 등 managed secret store 사용 시 API/secret 비용 | fake provider 또는 local provider로 Secret 동기화 흐름 학습 |
| Provider 선택형 | cert-manager ACME DNS01, Let's Encrypt | DNS provider 필요 | Route53/Cloud DNS 같은 DNS provider API와 hosted zone 비용 | SelfSigned/CA issuer로 먼저 학습하고 ACME DNS01은 문서 개념으로 분리 |
| Provider 선택형 | Prometheus, Grafana, Alertmanager, Loki, Tempo | object storage/long-term storage는 선택 | 장기 보관용 object/block storage, managed observability 비용 | 로컬 PVC와 짧은 retention으로 metric/log/trace 흐름 검증 |
| Provider 선택형 | Velero, VolumeSnapshot | object store와 snapshot provider 필요 | S3/EBS snapshot 등 cloud storage/snapshot 비용 | MinIO 또는 local object storage 기반 namespace backup/restore 학습 |
| Provider 선택형 | Terraform/Terragrunt | 사용하는 provider에 따라 달라짐 | EKS/NKS/VPC/LB/storage provider resource 생성 시 비용 | local backend, 비용 없는 provider, HCL formatting/validation 중심 |
| AWS EKS 선택 실습 | Karpenter, NodePool, EC2NodeClass, NodeClaim | AWS provider/EKS/EC2 의존 | EKS control plane, EC2 instance, EBS, Public IPv4, data transfer, Load Balancer 가능성 | 기본은 문서/설계 학습. 명시적 비용 승인 후 AWS EKS에서만 제한 실습 |
| Cloud 의존 | EKS/NKS managed cluster | AWS 또는 NHN Cloud provider 필요 | control plane, worker node, storage, LB/IP/network 비용 | 비용 산정과 운영 판단 기준만 문서화 |
| Cloud 의존 | cloud Load Balancer, NAT Gateway, Public IPv4/Floating IP | cloud networking provider 필요 | LB-hour, LCU/NLCU, NAT-hour/data, IP-hour 비용 | 로컬 NodePort/port-forward/host network로 대체 |

### 판단 기준

- Kubernetes 안에서 동작하는 controller만 설치하면 되는 기술은 대부분 kind에서 비용 없이 학습한다.
- 외부 secret store, DNS, object storage, snapshot, cloud Load Balancer가 필요한 기능은 provider 선택형으로 둔다.
- cloud API가 실제 compute/network/storage를 만드는 기술은 비용 승인 전까지 실행하지 않는다.
- Karpenter는 단순 controller 설치보다 EC2 node provisioning이 핵심이므로 이 프로젝트에서 가장 강한 비용 경계가 필요한 기술이다.
- Karpenter의 실제 클라우드 실습 대상은 AWS EKS로 한정한다. NHN Cloud NKS는 Karpenter 실행 대상이 아니라 비용 비교와 cluster 삭제 전략 대상으로 둔다.
- Terraform/Terragrunt는 cloud provider를 선택하기 전까지는 구조 학습 도구로 보고, provider resource 생성 단계부터 비용 리스크로 본다.

## 월 예상 비용 요약

| Cloud | Control plane | Worker node | Block storage | 기본 합계 | 포함하지 않은 항목 |
| --- | ---: | ---: | ---: | ---: | --- |
| NHN Cloud | 73,000원 | 203,670원 | 10,512원 | 287,182원/월 | VAT, Load Balancer, Floating IP, outbound, snapshot |
| AWS | 73.00 USD | 113.88 USD | 8.21 USD | 195.09 USD/월 | tax, 환율, Public IPv4, Load Balancer, NAT Gateway, egress, CloudWatch |

이 표는 서로 다른 통화를 그대로 둔다. 원화 환산은 환율 기준일에 따라 결과가 달라지므로 별도 계산한다.

## NHN Cloud 산정

기준은 NHN Cloud 공공기관용 공개 요금표다. 일반 NHN Cloud 계정, 리전, 계약 조건에 따라 실제 청구 금액은 달라질 수 있다.

| 항목 | 단가 | 수량 | 계산식 | 월 비용 |
| --- | ---: | ---: | --- | ---: |
| NHN Kubernetes Service(NKS) cluster | 100원/시간 | 1개 | `100 * 730` | 73,000원 |
| Instance `m2.c2m4` | 93원/시간 | 3대 | `93 * 3 * 730` | 203,670원 |
| SSD Block Storage | 10GB당 1.6원/시간 | 90GB | `(90 / 10) * 1.6 * 730` | 10,512원 |
| 합계 |  |  | `73,000 + 203,670 + 10,512` | 287,182원 |

비용 리스크:

- NKS 요금은 worker node용 Instance와 관련 리소스 비용을 포함하지 않는다.
- Kubernetes 버전 업그레이드 또는 CNI 변경 중 buffer node가 생성될 수 있고, 이때 Instance 비용이 추가될 수 있다.
- NKS network outbound는 별도 과금 구간을 가진다.
- Worker node에서 발생하는 outbound는 Instance network 요금 정책을 같이 확인해야 한다.
- Load Balancer, Floating IP, snapshot, image, logging 저장소는 기본 합계에서 제외했다.

## AWS 산정

기준은 AWS Seoul 리전(`ap-northeast-2`), Linux On-Demand, EKS standard support다. EC2와 EBS 단가는 AWS Price List API에서 확인했다.

| 항목 | 단가 | 수량 | 계산식 | 월 비용 |
| --- | ---: | ---: | --- | ---: |
| EKS standard support cluster | 0.10 USD/시간 | 1개 | `0.10 * 730` | 73.00 USD |
| EC2 `t3.medium` Linux On-Demand | 0.052 USD/시간 | 3대 | `0.052 * 3 * 730` | 113.88 USD |
| EBS gp3 storage | 0.0912 USD/GB-month | 90GB | `90 * 0.0912` | 8.21 USD |
| 합계 |  |  | `73.00 + 113.88 + 8.21` | 195.09 USD |

비용 리스크:

- EKS cluster는 Kubernetes version support tier에 따라 cluster-hour 요금이 달라진다. 표는 standard support 기준이다.
- Worker node에 public IPv4를 붙이면 IPv4 시간당 요금이 추가될 수 있다.
- Application Load Balancer, Network Load Balancer, NAT Gateway, data transfer out, CloudWatch Logs/Metrics, EBS snapshot은 기본 합계에서 제외했다.
- `t3.medium`은 burstable instance다. 지속적인 CPU 부하 실습에는 `m6i.large` 또는 `m7i.large` 같은 대안을 검토해야 한다.
- Managed node group, add-on, upgrade, observability 구성을 추가하면 temporary node와 저장소 비용이 늘 수 있다.

## 해석

이 저장소의 학습 목적에서는 로컬 kind/Colima가 기본 경로다. 위 비용은 “로컬 랩을 managed Kubernetes에 올리면 어느 정도의 고정 비용이 생기는가”를 이해하기 위한 기준선이다.

학습용으로 클라우드 비용을 실제 지출해야 한다면 먼저 다음 순서로 줄인다.

1. 실습 시간에만 cluster를 만들고 즉시 삭제한다.
2. 3 worker 구성을 1 worker 또는 2 worker로 낮출 수 있는지 확인한다.
3. Public IPv4, Load Balancer, NAT Gateway를 만들지 않는 private-only 실습을 우선한다.
4. 관측성 stack은 로컬에서 먼저 검증하고, 클라우드에서는 로그 보관 기간과 volume 크기를 작게 시작한다.
5. Karpenter/cluster autoscaling은 실제 cloud API를 연결하기 전에 문서 설계와 로컬 HPA/KEDA 실습으로 대체한다.
6. Karpenter 실제 동작 확인이 꼭 필요하면 명시적 비용 승인 후 AWS EKS에서만 제한 실습하고, 학습 후 cluster를 삭제한다.

## 학습하지 않을 때 절약 전략

Managed Kubernetes는 일반 VM처럼 “cluster 전체 중지”가 되는 모델이 아닐 수 있다. 비용을 줄일 때는 control plane, worker node, storage, network resource를 분리해서 봐야 한다.

### AWS EKS

| 방법 | 줄어드는 비용 | 남는 비용과 주의 |
| --- | --- | --- |
| Managed node group을 0대까지 줄임 | EC2 worker instance 비용 | EKS cluster-hour, EBS volume, Load Balancer, NAT Gateway, Public IPv4 등은 별도 확인 필요 |
| Node group 삭제 | EC2 worker instance와 node group 관련 비용 | EKS control plane이 남아 있으면 cluster-hour 비용은 계속 발생 |
| Cluster 삭제 | EKS control plane 비용까지 제거 | Load Balancer, ingress, Prometheus scraper, VPC 관련 리소스가 남지 않았는지 확인 필요 |

AWS EKS managed node group은 Auto Scaling group 기반이며 `minSize`와 `desiredSize`의 최소값이 0이다. 따라서 worker node를 0대까지 줄이는 구성이 가능하다. 하지만 cluster가 존재하는 동안 EKS cluster-hour 비용은 계속 발생하므로, 장기간 학습하지 않을 때의 기본 절약 전략은 cluster 삭제다.

### NHN Cloud NKS

| 방법 | 줄어드는 비용 | 남는 비용과 주의 |
| --- | --- | --- |
| Node group 오토스케일러로 최소 노드 수까지 감축 | 일부 worker node 비용 | NKS cluster 비용, 최소 노드, network/storage 관련 비용은 남을 수 있음 |
| Node 또는 node group 삭제 | worker node 비용 | cluster 자체 비용과 Load Balancer/Floating IP/storage/snapshot 등은 별도 확인 필요 |
| Cluster 삭제 | NKS cluster 비용까지 제거 | 연결된 network/storage/logging resource 정리 여부 확인 필요 |

NHN Cloud NKS 문서의 클러스터 오토스케일러 설정은 최소 노드 수 유효 범위를 1-10으로 설명한다. 따라서 현재 문서 기준으로는 AWS EKS처럼 기본 절약 전략을 “worker 0대 유지”로 두기 어렵다. 장기간 학습하지 않을 때는 node/node group 삭제 또는 cluster 삭제를 비용 절약 기준으로 잡는다.

### 이 저장소의 권장 기본값

- 로컬 학습은 kind/Colima cluster를 만들고 실습 후 삭제한다.
- Terragrunt는 cloud provider 없이 local validation 중심으로 학습한다.
- Karpenter만 명시적 비용 승인 후 AWS EKS 선택 실습으로 다룰 수 있다.
- NHN Cloud NKS는 Karpenter 실행 대상이 아니라 비용 비교와 cluster 삭제 전략 문서로 다룬다.
- EKS/NKS 실험은 비용 승인 전까지 문서 설계와 비용 산정으로 제한한다.
- cloud cluster를 실제로 만들었다면 “잠시 쉬기”는 worker 축소, “장기간 중단”은 cluster 삭제를 기준으로 판단한다.
- Karpenter AWS EKS 선택 실습의 완료 기준은 workload 제거, NodeClaim/node 정리 확인, EKS cluster 삭제다.

## 출처

- NHN Kubernetes Service(NKS): https://www.gov-nhncloud.com/kr/service/container/nhn-kubernetes-service-nks
- NHN Cloud Instance: https://www.gov-nhncloud.com/kr/service/compute/instance
- NHN Cloud Block Storage: https://www.gov-nhncloud.com/kr/service/storage/block-storage
- NHN Cloud 서비스별 요금: https://www.gov-nhncloud.com/kr/pricing/by-service
- NHN Cloud NKS 개요: https://docs.nhncloud.com/ko/Container/NKS/ko/overview/
- NHN Cloud NKS 사용 가이드: https://docs.nhncloud.com/ko/Container/NKS/ko/user-guide/
- Amazon EKS pricing: https://aws.amazon.com/eks/pricing/
- Amazon EKS delete cluster: https://docs.aws.amazon.com/eks/latest/userguide/delete-cluster.html
- Amazon EKS managed node groups: https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html
- Amazon EKS NodegroupScalingConfig: https://docs.aws.amazon.com/eks/latest/APIReference/API_NodegroupScalingConfig.html
- Karpenter NodeClasses: https://karpenter.sh/docs/concepts/nodeclasses/
- Karpenter Getting Started: https://karpenter.sh/docs/getting-started/
- AWS EKS Karpenter best practices: https://docs.aws.amazon.com/eks/latest/best-practices/karpenter.html
- AWS EKS autoscaling: https://docs.aws.amazon.com/eks/latest/userguide/autoscaling.html
- Amazon EC2 On-Demand pricing: https://aws.amazon.com/ec2/pricing/on-demand/
- Amazon EBS pricing: https://aws.amazon.com/ebs/pricing/
- Amazon VPC pricing: https://aws.amazon.com/vpc/pricing/
- AWS Price List API, AmazonEC2 Seoul: https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonEC2/current/ap-northeast-2/index.json
- AWS Price List API, AmazonEKS: https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonEKS/current/index.json
- Terragrunt docs: https://terragrunt.gruntwork.io/docs/
- Terraform local backend: https://developer.hashicorp.com/terraform/language/backend/local
- kind: https://kind.sigs.k8s.io/
- Cilium Gateway API: https://docs.cilium.io/en/stable/network/servicemesh/gateway-api/gateway-api/
- Argo CD Getting Started: https://argo-cd.readthedocs.io/en/stable/getting_started/
- Kyverno installation: https://kyverno.io/docs/installation/
- External Secrets fake provider: https://external-secrets.io/latest/provider/fake/
- cert-manager SelfSigned issuer: https://cert-manager.io/docs/configuration/selfsigned/
- cert-manager ACME DNS01: https://cert-manager.io/docs/configuration/acme/dns01/
- KEDA Redis scaler: https://keda.sh/docs/latest/scalers/redis-lists/
- Prometheus Operator: https://prometheus-operator.dev/docs/getting-started/introduction/
- OpenTelemetry Operator: https://opentelemetry.io/docs/platforms/kubernetes/operator/
- Velero providers: https://velero.io/docs/main/supported-providers/
