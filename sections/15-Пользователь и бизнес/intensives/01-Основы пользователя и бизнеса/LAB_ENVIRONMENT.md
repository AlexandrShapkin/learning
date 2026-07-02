# Лабораторное окружение

## Базовая система

Recommended workstation or VM:

```text
product-business-lab
├── 4–8 CPU threads
├── 12–24 GiB RAM
├── 100+ GiB SSD
├── current supported Linux distribution
└── synthetic users, organizations, transactions and research data
```

All participants, organizations, financials and operational histories are synthetic unless explicit authorization is documented.

## Required tools

- Git, Bash, Make, curl, jq and yq;
- Go toolchain;
- Docker or Podman and Compose;
- PostgreSQL client/server or container;
- Python 3 or equivalent analysis environment;
- SQLite optional;
- Markdown editor;
- Mermaid, PlantUML or BPMN tool;
- browser developer and accessibility tools;
- standard CSV/JSON processing tools.

Recommended:

- Jupyter;
- pandas and matplotlib;
- DuckDB;
- Graphviz;
- Playwright or browser automation for usability fixtures;
- local analytics store/dashboard such as PostHog-like or simple SQL notebooks;
- spreadsheet software for small financial models;
- accessibility checkers such as axe in local scope;
- audio/transcript fixtures generated synthetically, not real participant recordings.

## Default reference system

```text
customer / requester
        |
web and API application
        |
dispatch and scheduling workflow
├── dispatcher
├── field worker
├── manager
├── support
└── customer notifications

business and evidence
├── PostgreSQL operational data
├── synthetic event stream
├── research repository
├── process and journey models
├── experiment/pilot datasets
├── financial model
└── rollout and support evidence
```

## Synthetic segments and roles

Use at least:

- small service company buyer/owner;
- operations manager;
- dispatcher;
- field worker;
- customer/requester;
- finance or procurement reviewer;
- support agent;
- administrator;
- non-adopter or constrained user;
- affected external partner.

## Workspace

```text
sprints/<NN-topic>/work/
├── research/
├── journeys/
├── processes/
├── requirements/
├── strategy/
├── analytics/
├── experiments/
├── economics/
├── rollout/
├── reports/
└── README.md
```

Create only directories used by the sprint.

## Research ethics and privacy

- use synthetic or explicitly authorized participants and data;
- state purpose, scope, recording and retention before each session;
- collect only evidence required by the research question;
- avoid deception unless separately reviewed and harmless;
- do not store sensitive personal data in repository artifacts;
- pseudonymize transcripts and remove identifiers;
- separate consent/identity data from research notes;
- provide withdrawal/deletion path for any real authorized participant;
- never infer protected or sensitive traits without legitimate need and review;
- avoid manipulative or dark-pattern experiments.

## Analytics and experiment safety

- event data is synthetic and schema-versioned;
- identifiers do not represent real people;
- experiments have exposure, duration and sample caps;
- guardrail outcomes include errors, accessibility, support and harm;
- no experiment blocks essential service or exploits vulnerable users;
- financial assumptions are labeled and range-tested;
- simulated pricing research does not contact real customers;
- generated datasets include fixed seeds and clear assumptions.

## Reproducibility evidence

Record:

- OS, Go, PostgreSQL and Python versions;
- product and event-schema revisions;
- synthetic-data generator seed;
- research question, sample logic and session protocol;
- analysis inclusion/exclusion rules;
- metric definitions and identity model;
- experiment assignment and guardrails;
- financial assumptions and scenario ranges;
- rollout/pilot cohort and decision thresholds;
- cleanup and data-retention result.

## Commit policy

Commit:

- synthetic research plans, scripts and redacted notes;
- segment, journey and process models;
- requirements and decision artifacts;
- event schemas and data-quality checks;
- analysis queries/notebooks/scripts;
- experiment and pilot configurations;
- financial model inputs and formulas;
- rollout, support and adoption plans;
- concise conclusions and uncertainty.

Do not commit:

- real names, contacts, recordings or personal data;
- company-confidential research or financial data;
- credentials, analytics tokens or production exports;
- unredacted transcripts or support tickets;
- proprietary market reports copied in full;
- large generated datasets or binary dashboards;
- conclusions without source and uncertainty;
- deceptive or manipulative experiment material.
