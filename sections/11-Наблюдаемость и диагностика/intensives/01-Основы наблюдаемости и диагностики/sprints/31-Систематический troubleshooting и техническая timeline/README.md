# Спринт 31. Систематический troubleshooting и техническая timeline

Ориентировочный объём: 20–30 часов.

## Центральный вопрос

Как последовательно локализовать unfamiliar failure, сохраняя evidence, controlling changes and reconstructing the earliest technical divergence?

## Результат спринта

После завершения необходимо уметь:

- define symptom, scope, onset and expected path;
- preserve revisions, events, profiles and state before mutation;
- create dependency and timeline views;
- use binary search and healthy/faulty comparison;
- rank competing hypotheses;
- run one discriminating observation at a time;
- distinguish trigger, contributing factors and downstream effects;
- identify first divergence and uncertainty;
- choose telemetry, profiling or system tool by question;
- avoid restart/rollback as unexplained diagnosis;
- verify repair from user path, data and resource state;
- convert findings into instrumentation/query/runbook improvement.

## Diagnostic loop

```text
state exact symptom and impact
→ identify expected request/data/resource path
→ preserve release/config/schema/telemetry evidence
→ build timeline and dependency scope
→ rank falsifiable hypotheses
→ select one discriminating observation
→ locate first divergence
→ repair minimally and reversibly
→ verify user path, data and system baseline
→ improve instrumentation or diagnostic procedure
```

## Лабораторная работа

Создать `work/systematic-troubleshooting/`.

### Required cases

Solve at least 16 single-layer and 6 combined faults:

- application logic/error classification;
- runtime CPU/memory/goroutine/lock issue;
- database pool/query/transaction issue;
- DNS/TCP/TLS/retransmission issue;
- disk latency/capacity/I/O issue;
- Kubernetes scheduling/probe/network/storage issue;
- log/metric/trace/profiler pipeline loss;
- release/config/schema mismatch;
- retry/fan-out/queue amplification;
- observability-platform overload.

### Requirements

- every case starts from user-visible or operator symptom;
- first evidence set is captured before destructive action;
- hypothesis log records prediction and outcome;
- at least one leading hypothesis is falsified per case;
- timeline separates event time, ingestion time and uncertainty;
- healthy/faulty comparison uses equivalent load/config where possible;
- repair is minimal and desired state is restored;
- verification includes user behavior, persistent state and telemetry health;
- each case adds one reusable query, check, dashboard link or runbook step;
- broad restart, scaling or rollback is not accepted as root explanation.

### Failure scenarios

1. Operator jumps directly to familiar tool/component.
2. Multiple configuration changes obscure cause.
3. Evidence disappears after restart/cleanup.
4. Telemetry-platform outage is mistaken for service outage.
5. Last deployment is blamed despite earlier divergence.
6. Correlated clock times are treated as causality.
7. Repair fixes symptom but leaves data/backlog/resource issue.
8. Diagnosis stops at downstream timeout.
9. Healthy baseline differs materially.

## Самопроверка

1. Exact symptom formulation?
2. Evidence-preservation minimum?
3. Competing/falsifiable hypotheses?
4. Discriminating observation?
5. First divergence?
6. Timeline uncertainty?
7. Healthy/faulty comparison?
8. Trigger versus contributing factor?
9. Repair verification?
10. How improve future diagnosis?

## Результат для базы знаний

- **Systematic technical troubleshooting loop**.
- **Diagnostic hypothesis logs and discriminating observations**.
- **Technical timelines and evidence preservation**.
- **First divergence, trigger and contributing factors**.
- **Repair verification and diagnostic feedback loops**.

## Когда переходить дальше

Можно переходить, когда unfamiliar faults are localized through falsifiable hypotheses and bounded evidence, and repair verification covers user behavior, data and telemetry rather than one cleared alert.