# Chapter 10. Karpenter

## 목표

Karpenter가 해결하는 node provisioning 문제를 이해하고 HPA/KEDA, Cluster Autoscaler, EKS Managed Node Group과 비교한다.

## 학습 대상

- Karpenter
- NodePool
- EC2NodeClass
- NodeClaim
- consolidation
- Spot / On-Demand 혼합
- Cluster Autoscaler와의 차이
- EKS Managed Node Group과의 관계

## 기존 자료

- [학습 주제: Karpenter 개념](../../guides/learning-topics.md)
- [cloud provider 비용 분류](../../docs/cloud-cost-estimation.md)
- 예정 문서: `docs/karpenter-concepts.md`

## 실습 방식

기본은 문서/설계 학습이다. NodePool, EC2NodeClass, NodeClaim manifest는 예시로만 다룬다.

실제 node provisioning 확인이 필요하면 명시적 비용 승인 후 AWS EKS 선택 실습으로만 다룬다. NHN Cloud NKS는 Karpenter 실행 대상이 아니라 managed cluster 비용과 삭제 전략 비교 대상으로 둔다.

## 검증 기준

- NodePool, EC2NodeClass, NodeClaim의 관계를 설명할 수 있다.
- Karpenter와 HPA/KEDA가 해결하는 문제가 어떻게 다른지 설명할 수 있다.
- consolidation과 Spot/On-Demand 비용 모델의 장단점을 설명할 수 있다.
- AWS EKS 선택 실습을 했다면 workload 제거, NodeClaim/node 정리 확인, EKS cluster 삭제까지 완료할 수 있다.

## 정리 기준

- 기본 문서 학습에서는 cloud resource를 만들지 않는다.
- AWS EKS 선택 실습을 했다면 workload, NodeClaim/node, EKS cluster가 남지 않았는지 확인한다.
- 비용 승인 전에는 AWS API와 연결되는 설치/적용 절차를 작성하지 않는다.

## 다음 챕터

- 전체 학습을 복습하고 부족한 주제를 보강한다.
