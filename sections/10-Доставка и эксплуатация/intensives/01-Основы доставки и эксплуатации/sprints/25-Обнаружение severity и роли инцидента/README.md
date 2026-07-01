# Спринт 25. Обнаружение, severity и роли инцидента

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как decide that an abnormal condition is an incident, assess user/business impact and establish clear response roles before diagnosis becomes chaotic?

## Результат спринта

После завершения необходимо уметь:

- distinguish event, alert, ticket, problem and incident;
- declare incidents from user impact and risk;
- define severity levels with examples and response expectations;
- avoid severity based only on technical component status;
- establish incident commander, operations/technical lead, communications and scribe roles;
- define ownership and handoff/on-call escalation;
- create initial incident statement and scope;
- track timeline, hypotheses, actions and decisions;
- avoid multiple uncoordinated responders mutating the system;
- manage parallel workstreams;
- downgrade/upgrade severity based on evidence;
- define incident end and transition to follow-up.

## Основной маршрут

1. Create severity matrix for availability, data integrity, security suspicion and release failure.
2. Run three synthetic alerts and decide which become incidents.
3. Assign roles and open incident record.
4. Reclassify severity as impact expands/contracts.

## Лабораторная работа

Создать `work/incident-declaration/`.

### Requirements

- severity definitions include user impact, scope, data risk and response expectations;
- incident declaration records time, reporter, symptoms and affected service;
- roles have explicit authority and do not overlap ambiguously;
- technical responders report through one coordination channel;
- timeline distinguishes observations, hypotheses, actions and results;
- severity changes are logged with evidence;
- on-call/escalation path includes unavailable primary responder;
- incident can be declared from uncertain but high-risk data-integrity signal;
- end criteria include stable service, bounded risk and follow-up owner;
- alert noise/non-incidents are recorded for detection improvement.

### Failure scenarios

1. Database CPU alert is severity 1 without user impact.
2. Data corruption suspicion is ignored because availability is normal.
3. Everyone acts as incident commander and technical lead.
4. Multiple responders restart/change different layers without coordination.
5. Severity never changes as scope becomes clear.
6. Incident closes when graph turns green but backlog/data risk remains.
7. No scribe/timeline exists and decisions cannot be reconstructed.
8. Primary on-call does not respond and escalation has no fallback.

## Результат для базы знаний

- **Events, alerts and incidents**.
- **Incident severity based on impact and risk**.
- **Incident command roles and authority**.
- **Incident declaration, timeline and closure**.
- **On-call escalation and role handoff**.

## Когда переходить дальше

Можно переходить, когда incidents are declared and staffed from impact/risk evidence, with one coordinated timeline and explicit authority for actions and escalation.