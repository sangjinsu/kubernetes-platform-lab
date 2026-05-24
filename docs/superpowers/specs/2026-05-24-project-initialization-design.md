# 프로젝트 초기화 설계 기록

날짜: 2026-05-24

## 승인된 방향

사용자는 1번안을 승인했다.

- 루트 `AGENTS.md`는 짧은 인덱스와 핵심 원칙만 유지한다.
- 세부 지침은 `guides/` 아래 문서로 분리한다.
- 루트 `AGENTS.md`에는 `@guides/*.md` 형식의 명시적 참조를 둔다.

## 분리 기준

- `guides/project-overview.md`: 목적, 기본 전제, Codex 작업 원칙
- `guides/learning-topics.md`: 학습 주제별 목표, 필수 실습, 검증 기준
- `guides/lab-standards.md`: 권장 구조, 랩 표준 구성, 코드 스타일, 요청 예시
- `guides/testing-policy.md`: kubeconform, Helm, kubectl, Cilium, Kyverno, Argo CD 검증 명령
- `guides/roadmap.md`: Phase 1-6 산출물, 우선순위, 완료 기준
- `guides/safety.md`: 금지 사항, AWS 비용 주의, 운영 관점 체크리스트

## 초기화 범위

- 기본 디렉터리: `apps`, `docs`, `guides`, `labs`, `scripts`, `tests`
- 테스트 하위 디렉터리: `tests/kubeconform`, `tests/helm`, `tests/kyverno`, `tests/e2e`
- 스크립트: kind 생성/삭제, 도구 확인, 랩 검증
- 안전 ignore: OS/editor/temp, kubeconfig, secret, Terraform state
