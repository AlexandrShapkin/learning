# Лабораторное окружение

## Базовая система

Recommended workstation or VM:

```text
engineering-system-lab
├── 4–8 CPU threads
├── 12–24 GiB RAM
├── 80+ GiB SSD
├── current supported Linux distribution
└── isolated synthetic repositories, issues and data
```

The intensive does not require production services. All collaboration data, incidents, metrics and organizational roles are synthetic.

## Required tools

- Git, Bash, Make, curl, jq and yq;
- Go toolchain;
- Docker or Podman and Compose;
- PostgreSQL client/server or container;
- Markdown editor;
- `go test`, race detector, coverage and fuzzing support;
- `staticcheck` or `golangci-lint`;
- `govulncheck`;
- standard diff, patch and filesystem tools.

Recommended:

- GitHub CLI or equivalent forge client;
- act or another local CI workflow runner;
- Mermaid CLI or PlantUML;
- Python and SQLite for synthetic metrics;
- Graphviz;
- pre-commit or lefthook;
- shellcheck and markdownlint;
- conventional-commit/check scripts only as optional examples;
- CODEOWNERS and merge-queue examples;
- issue/PR templates used critically rather than as compulsory forms.

## Default laboratory

```text
synthetic product repository
├── Go API and worker
├── PostgreSQL
├── tests and CI workflows
├── docs, RFC and ADR
├── issue/change specifications
├── ownership and review rules
└── generated engineering history

analysis tools
├── Git history inspection
├── review and test evidence
├── flow/quality metric scripts
├── process fault injector
└── read-only engtriage
```

## Synthetic roles

Use role labels rather than real people:

- requester or stakeholder;
- product/requirements owner;
- implementer;
- reviewer;
- maintainer;
- quality/security/operations reviewer;
- incident or delivery coordinator;
- new contributor;
- dependent-team representative.

A single learner may perform all roles sequentially, preserving separate perspectives and evidence.

## Workspace

```text
sprints/<NN-topic>/work/
├── product/
├── requirements/
├── changes/
├── reviews/
├── tests/
├── decisions/
├── docs/
├── metrics/
├── experiments/
├── reports/
└── README.md
```

Create only directories used by the sprint. Do not pre-create empty tracking systems.

## Synthetic history

Scripts may generate:

- issue arrival/completion timestamps;
- change sizes and dependencies;
- review waiting time and iterations;
- test failures and escaped defects;
- deployment/recovery outcomes;
- blocked work and WIP states;
- documentation and ownership gaps.

Generated histories must include a fixed seed and clear assumptions. They are learning data, not claims about real teams.

## Process-experiment safety

- no experiment changes real organization workflow;
- no metrics are applied to individual performance;
- no real private repository, issue, review or employee data is imported;
- no automation merges, closes or rewrites external repositories;
- Git history-rewrite practice uses disposable branches/repositories only;
- scripts default to dry-run for destructive Git operations;
- CI and test loads have bounded duration and resource use;
- issue/PR simulations use local files or dedicated synthetic repositories.

## Reproducibility evidence

Record:

- OS, Git and Go versions;
- repository commit and branch model;
- generated-history seed and assumptions;
- problem/requirement/change revision;
- test and CI configuration revision;
- review policy and ownership revision;
- metric definitions and excluded intervals;
- experiment hypothesis, duration and result;
- rollback/cleanup result.

## Commit policy

Commit:

- product source and tests;
- issue/change specifications;
- RFC, ADR and documentation;
- review checklists or prompts that proved useful;
- CI and quality-gate configuration;
- synthetic history generators;
- metric definitions and scripts;
- concise experiment and retrospective reports;
- commands for reproducing evidence.

Do not commit:

- real organization issues, reviews, messages or metrics;
- personal performance data;
- access tokens or private repository exports;
- copied proprietary process documents;
- large generated histories or CI artifacts;
- empty ceremony templates with no demonstrated purpose;
- binaries, database volumes or transient caches.
