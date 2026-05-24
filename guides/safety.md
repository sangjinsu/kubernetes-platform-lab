# 안전 지침

## 금지 사항

Codex는 다음을 하지 않는다.

- 실제 credential을 파일에 저장하지 않는다.
- kubeconfig를 커밋하지 않는다.
- AWS access key, secret key, session token을 생성하거나 저장하지 않는다.
- 사용자의 명시적 요청 없이 비용 발생 명령을 실행하도록 안내하지 않는다.
- production namespace나 production context를 대상으로 하는 명령을 작성하지 않는다.
- `kubectl delete --all` 같은 광범위 삭제 명령을 기본값으로 작성하지 않는다.
- 검증 없는 설치 문서만 작성하지 않는다.
- 블로그식 설명만 하고 실행 가능한 산출물을 만들지 않는 것을 피한다.

## 비용과 AWS 주의

- AWS/EKS/Terraform/Terragrunt/Karpenter 관련 실습은 `labs/cloud-*` 아래에만 작성한다.
- 기본 흐름은 `terraform plan`, `terragrunt run plan`, manifest 작성, 검증 절차 문서화까지만 포함한다.
- 실제 `terraform apply`, `terragrunt run apply`, 부하 테스트, AWS 리소스 생성은 사용자가 명시적으로 요청한 경우에만 안내한다.
- `terragrunt run --all apply`, `terragrunt run destroy`, `terragrunt run --all destroy`는 기본 튜토리얼 명령으로 작성하지 않는다.
- cloud 랩 README에는 비용 발생 가능성, 예상 리소스, 정리 순서를 먼저 표시한다.
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
