# 안전 지침

## 금지 사항

Codex는 다음을 하지 않는다.

- 실제 credential을 파일에 저장하지 않는다.
- kubeconfig를 커밋하지 않는다.
- AWS access key, secret key, session token을 생성하거나 저장하지 않는다.
- AWS/EKS/NHN Cloud는 비용 문제로 기본 학습 환경에서 사용하지 않는다.
- Karpenter만 명시적 비용 승인 후 AWS EKS 선택 실습으로 다룰 수 있다.
- NHN Cloud NKS는 Karpenter 실행 대상이 아니라 비용 비교와 cluster 삭제 전략 문서로 다룬다.
- 사용자의 명시적 요청 없이 비용 발생 명령을 실행하도록 안내하지 않는다.
- production namespace나 production context를 대상으로 하는 명령을 작성하지 않는다.
- `kubectl delete --all` 같은 광범위 삭제 명령을 기본값으로 작성하지 않는다.
- 검증 없는 설치 문서만 작성하지 않는다.
- 블로그식 설명만 하고 실행 가능한 산출물을 만들지 않는 것을 피한다.

## 비용과 AWS 주의

- AWS/EKS/NHN Cloud 실행 실습은 기본 학습 범위에서 제외한다.
- Karpenter만 명시적 비용 승인 후 AWS EKS 선택 실습으로 다룰 수 있다.
- AWS provider, AWS CLI, EKS, Karpenter controller 설치를 요구하는 명령은 기본 튜토리얼에 작성하지 않는다.
- Terraform/Terragrunt는 로컬 또는 비용 없는 static validation 중심으로만 사용한다.
- 실제 `terraform apply`, `terragrunt run apply`, 부하 테스트, AWS/NHN Cloud 리소스 생성은 사용자가 명시적으로 비용 승인을 한 경우에만 별도 문서로 안내한다.
- `terragrunt run --all apply`, `terragrunt run destroy`, `terragrunt run --all destroy`는 기본 튜토리얼 명령으로 작성하지 않는다.
- AWS/NHN Cloud 관련 문서는 실행 절차보다 비용 영향, 대체 로컬 실습, 운영 설계 판단 기준을 먼저 표시한다.
- AWS 또는 NHN Cloud cluster를 만든 경우 학습 종료 후 중지가 아니라 삭제를 기본 절약 전략으로 둔다.
- 민감 정보는 환경 변수 또는 외부 secret store를 전제로 설명하고 저장소 파일로 만들지 않는다.

## 운영 관점 체크리스트

각 기술을 학습할 때 다음 질문에 답한다.

1. 이 기술은 어떤 문제를 해결하는가?
2. 기존 방식과 비교했을 때 장점은 무엇인가?
3. 운영 복잡도는 얼마나 증가하는가?
4. 장애가 나면 어떤 증상이 발생하는가?
5. 어떤 metric, log, event를 봐야 하는가?
6. 롤백 또는 제거 절차는 무엇인가?
7. 비용에 영향을 주는가?
8. 보안상 주의할 점은 무엇인가?
9. 게임 서버 또는 MSA 환경에서 실제로 사용할 만한가?
10. 지금 우리 팀에 도입한다면 선행 조건은 무엇인가?
