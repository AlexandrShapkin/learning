# Спринт 26. Incident command, escalation и коммуникация

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как coordinate people, technical work and stakeholder communication during an incident so that response remains focused, truthful and sustainable?

## Результат спринта

После завершения необходимо уметь:

- run incident command cadence;
- separate command, technical investigation and communications;
- create working incident objective and next-update time;
- manage hypotheses, workstreams and action ownership;
- escalate by missing expertise, authority, capacity or duration;
- communicate known impact, uncertainty and mitigation without speculation;
- write internal and external updates for different audiences;
- use status page and support/customer channels consistently;
- handle shift changes and responder fatigue;
- avoid unsafe pressure from stakeholders;
- document decisions and rejected actions;
- coordinate vendors/providers without outsourcing ownership.

## Основной маршрут

1. Run a 90-minute simulated incident with assigned roles.
2. Publish initial, ongoing, mitigation and resolved updates.
3. Escalate when primary diagnosis stalls.
4. Perform responder handoff while incident remains active.
5. Compare technical timeline and stakeholder communication timeline.

## Лабораторная работа

Создать `work/incident-command/`.

### Requirements

- incident commander states priority, workstreams and update cadence;
- every action has owner and expected observation;
- technical chat does not replace the authoritative incident timeline;
- communications distinguish confirmed facts, impact, mitigation and unknowns;
- public updates contain no secrets, blame or unsupported ETA;
- support/product/legal/security stakeholders are engaged by predefined triggers;
- provider escalation includes evidence and local mitigation ownership;
- responder shifts/handoffs include current state, risks and next actions;
- decision log records why risky actions were accepted/rejected;
- resolved update states service status and remaining follow-up, not guessed root cause.

### Failure scenarios

1. No next-update time creates repeated stakeholder interruptions.
2. Public status says “resolved” while backlog/data verification continues.
3. Unverified root cause or ETA is communicated.
4. Executives direct technical commands outside incident command.
5. Vendor ticket causes team to stop local mitigation.
6. One responder remains on critical task until exhaustion.
7. Shift handoff loses hypotheses/actions.
8. Sensitive customer/system details leak in public update.
9. Parallel workstreams duplicate or conflict.

## Результат для базы знаний

- **Incident command and response coordination**.
- **Incident escalation triggers and provider coordination**.
- **Internal and external incident communication**.
- **Incident workstreams, cadence and handoff**.
- **Incident decision logs and uncertainty communication**.

## Когда переходить дальше

Можно переходить, когда a multi-role incident simulation maintains one objective, timeline and communication cadence through escalation and responder handoff.