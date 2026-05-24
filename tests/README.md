# tests

공통 검증 자산을 보관하는 디렉터리입니다.

- `kubeconform`: Kubernetes manifest schema 검증 자산
- `helm`: Helm chart lint/template 검증 자산
- `kyverno`: Kyverno policy test 자산
- `e2e`: kind 기반 end-to-end 검증 자산

랩별 테스트가 더 자연스러운 경우에는 해당 `labs/*/tests` 아래에 두고, 공통 재사용 자산만 이 디렉터리에 둔다.
