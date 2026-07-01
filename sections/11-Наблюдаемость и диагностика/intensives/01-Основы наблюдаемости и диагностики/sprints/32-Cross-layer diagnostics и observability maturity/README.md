# Спринт 32. Cross-layer diagnostics и observability maturity

Ориентировочный объём: 20–30 часов.

## Центральный вопрос

Как определить границу проблемы между application, runtime, operating system, network, storage, Kubernetes and telemetry platform, and how assess whether observability capabilities actually reduce diagnostic uncertainty?

## Результат спринта

После завершения необходимо уметь:

- correlate user journey with process, container, node, network and storage paths;
- map service/instance/Pod/container/PID/cgroup identities;
- distinguish application latency from queue, network, storage and scheduler delay;
- diagnose partial and asymmetric failures;
- identify telemetry blind spots and confidence limits;
- create cross-layer diagnostic decision tree without rigid scripts;
- define observability capability levels by questions answered;
- measure time-to-scope, time-to-first-hypothesis and time-to-first-divergence;
- evaluate instrumentation coverage and cost together;
- prioritize gaps by failure risk and response value;
- design read-only triage bundles;
- avoid maturity scoring as vanity target.

## Основной маршрут

1. Trace one request from client through DNS/TCP/ingress/Pod/process/runtime/DB/storage.
2. Inject combined application and platform symptoms.
3. Build identity and dependency correlation map.
4. Measure diagnosis with and without selected telemetry.
5. Create prioritized observability gap plan.

## Лабораторная работа

Создать `work/cross-layer-diagnostics/`.

### `obstriage`

Read-only commands:

```text
obstriage path --service NAME
obstriage request --trace-id ID
obstriage process --pid PID
obstriage pod --namespace NS --name NAME
obstriage network --source A --destination B
obstriage storage --target NAME
obstriage telemetry --signal logs|metrics|traces|profiles
obstriage timeline --from TIME --to TIME
```

### Requirements

- canonical identity links release/service/instance/Pod/container/PID/cgroup/node;
- request path includes DNS, connection, application, dependency and storage boundaries;
- tool collects bounded read-only evidence and redacts sensitive fields;
- at least eight combined faults cross two or more layers;
- investigation identifies first divergence and downstream symptoms;
- telemetry blind spots are demonstrated through fault replay;
- capability assessment names questions that can/cannot be answered;
- improvements are prioritized by diagnostic value, risk and cost;
- diagnosis-time measures are used as feedback, not personnel targets;
- tool has explicit time/output limits and no mutation commands;
- generated raw bundles are excluded from Git.

### Combined fault examples

- retry storm + DB pool exhaustion + healthy CPU average;
- DNS latency + connection reuse + misleading application span;
- node disk pressure + telemetry drop + Pod restart;
- config revision mismatch + trace sampling gap;
- network retransmission + queue backlog + SLO burn;
- collector overload + missing metrics + healthy synthetic endpoint;
- memory leak + HPA scale-out + cardinality growth;
- storage latency + lock contention + long transaction.

## Самопроверка

1. How correlate identities across layers?
2. Request path boundaries?
3. Application versus queue/network/storage latency?
4. Partial/asymmetric failure?
5. Telemetry confidence and blind spots?
6. What makes triage tooling safe?
7. Capability versus tool inventory?
8. How measure diagnostic improvement?
9. How prioritize observability gaps?
10. Why avoid maturity vanity scores?

## Результат для базы знаний

- **Cross-layer application and infrastructure diagnostics**.
- **Workload identity correlation across telemetry layers**.
- **Diagnostic blind spots and evidence confidence**.
- **Read-only observability triage tooling**.
- **Observability capability and diagnostic-value assessment**.

## Когда переходить дальше

Можно переходить к итоговой работе, когда combined faults are localized across layer boundaries and observability improvements are selected by reduced uncertainty and response value rather than tool count.