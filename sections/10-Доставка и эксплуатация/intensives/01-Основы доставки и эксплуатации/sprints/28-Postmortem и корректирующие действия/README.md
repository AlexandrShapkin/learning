# Спринт 28. Postmortem и корректирующие действия

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как reconstruct why an incident became possible and costly, without reducing explanation to individual error, and turn learning into verified changes?

## Результат спринта

После завершения необходимо уметь:

- separate timeline, contributing factors, trigger and impact;
- avoid single root-cause and blame narratives;
- analyze technical, process, organizational and detection conditions;
- distinguish counterfactual certainty from evidence;
- identify why safeguards were absent, weak or bypassed;
- explain normal work and local rationality;
- create corrective actions by prevention, detection, mitigation and recovery;
- prioritize actions by risk reduction and cost;
- assign owner, deadline/trigger and verification;
- avoid vague “be careful/add monitoring” actions;
- share sanitized learning;
- close actions only after effectiveness evidence.

## Основной маршрут

1. Use a synthetic incident timeline from previous sprints.
2. Interview/respond from multiple role perspectives.
3. Build contributing-factor and control-gap map.
4. Write postmortem and propose actions.
5. Implement two actions and replay the incident.

## Лабораторная работа

Создать `work/postmortem/`.

### Requirements

- impact and customer-visible duration are quantified honestly;
- timeline distinguishes observations, decisions, actions and outcomes;
- trigger is not presented as sole cause;
- contributing factors include delivery, runtime, detection and recovery conditions;
- human actions are explained in available context;
- uncertainty and missing evidence are explicit;
- actions map to named recurrence/detection/mitigation/recovery gaps;
- each action has owner, priority and verification test;
- at least one tempting low-value action is rejected;
- incident replay proves two completed actions change outcome;
- sanitized summary contains no secrets/blame/private data.

### Failure scenarios

1. Root cause is “operator deployed bad code”.
2. Timeline is reconstructed from memory without evidence/uncertainty.
3. Action is “add monitoring” without signal/owner/response.
4. Every contributor produces an unprioritized backlog.
5. Training/documentation is chosen instead of fixing unsafe system default.
6. Action closes when ticket is merged, not when incident outcome changes.
7. Postmortem hides decision/coordination failures.
8. Blamelessness prevents accountability for system improvement.
9. Report leaks sensitive incident/customer information.

## Результат для базы знаний

- **Incident postmortem timeline and contributing factors**.
- **Blameless analysis and local rationality**.
- **Incident trigger versus systemic causes**.
- **Corrective actions for prevention, detection, mitigation and recovery**.
- **Postmortem action verification**.

## Когда переходить дальше

Можно переходить, когда incident replay demonstrates that completed actions reduce impact or recovery time, and the explanation accounts for interacting conditions rather than one person or one trigger.