# labs

주제별 Kubernetes 실습을 보관하는 디렉터리입니다.

각 랩은 다음 구조를 따른다.

```text
labs/local-example
├── README.md
├── manifests
├── helm-values
├── scripts
│   ├── install.sh
│   ├── verify.sh
│   └── cleanup.sh
└── tests
```

로컬 실습은 `labs/local-*` 아래에 작성한다. AWS/EKS/Karpenter는 비용 제약 때문에 실행 랩으로 만들지 않고, 필요한 경우 `docs/` 아래 개념/설계 문서로만 작성한다.
