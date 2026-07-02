# Спринт 29. Security logging, SIEM и detection engineering

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Какие события позволяют обнаружить злоупотребление или компрометацию, не превращая журналы в хранилище секретов и бесконечный шум?

## Результат спринта

После завершения необходимо уметь:

- define security-relevant events and required fields;
- collect identity, authorization, admin, secret, data and platform events;
- normalize event schemas and time/identity context;
- distinguish detection hypothesis from generic alert;
- create threshold, sequence and correlation detections;
- map detections to threats/ATT&CK carefully;
- handle baseline, suppression and rare-event cases;
- test detections with synthetic events;
- measure precision, recall proxies and triage cost;
- protect log integrity, access and retention;
- detect telemetry loss and tampering;
- document response playbooks.

## Основной маршрут

1. Create security event catalogue from threat model.
2. Normalize events into local SIEM-like store.
3. Implement at least ten detection hypotheses.
4. Replay benign and malicious synthetic sequences.
5. Tune and link detections to triage procedures.

## Лабораторная работа

Создать `work/detection-engineering/`.

### Requirements

- events include actor, target, action, result, source and revision context;
- secrets/tokens/personal payloads are redacted;
- log access and deletion are restricted/audited;
- detections name threat, required telemetry, expected false positives and response;
- identity/session/authorization changes are correlated across sources;
- telemetry pipeline health is monitored independently;
- synthetic tests cover true positive, benign variant and missing-data cases;
- one noisy rule is tuned or removed;
- suppression has scope, owner and expiry;
- alert links to relevant evidence and playbook.

### Failure scenarios

1. Login failures page without account/source/time context.
2. Token or password appears in event payload.
3. Attacker/workload can erase its own logs.
4. Detection relies on field/source not collected.
5. Pipeline outage appears as zero suspicious activity.
6. Rule matches routine automation and floods triage.
7. Suppression remains broad and permanent.

## Результат для базы знаний

- **Security event catalogues and schemas**.
- **Detection hypotheses and correlation rules**.
- **Security-log integrity, access and retention**.
- **Detection testing and tuning**.
- **Telemetry-loss and tampering detection**.

## Когда переходить дальше

Можно переходить, когда each alert corresponds to a tested threat hypothesis and missing/noisy telemetry cannot masquerade as security health.