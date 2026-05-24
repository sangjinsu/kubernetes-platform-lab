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

로컬 실습은 `labs/local-*`, AWS 비용이 발생할 수 있는 실습은 `labs/cloud-*` 아래에만 작성한다.
