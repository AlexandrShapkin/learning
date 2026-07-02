# Спринт 30. Endpoint, network detection и threat intelligence

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как использовать host, process and network evidence to detect suspicious behavior without treating every indicator as proof of compromise?

## Результат спринта

После завершения необходимо уметь:

- distinguish indicator, behavior, technique and confirmed incident;
- collect process, file, privilege, socket and network events;
- use auditd/Falco/IDS-like signals in local scope;
- create behavior-based detections rather than static indicator dependence;
- understand network metadata, DNS, TLS and flow limitations;
- use threat intelligence with source, age and confidence;
- map indicators to assets and exposure;
- identify living-off-the-land and administrative-tool ambiguity conceptually;
- tune host/network detections by workload baseline;
- preserve endpoint/network evidence safely;
- avoid uncontrolled packet/content collection.

## Основной маршрут

1. Collect host process/file/network events for the reference workload.
2. Add Falco/auditd rules for privilege and sensitive-file access.
3. Add local network-flow/DNS/TLS observations.
4. Replay synthetic suspicious and legitimate admin behaviors.
5. Enrich one case with threat-intelligence metadata and confidence.

## Лабораторная работа

Создать `work/endpoint-network-detection/`.

### Requirements

- detections bind behavior to exact host/container/workload identity;
- sensitive file, privilege, process and outbound connection events are collected;
- network data is limited by interface, filter, time and retention;
- rules distinguish expected deployment/admin processes from anomalies;
- threat intelligence records source, timestamp, confidence and applicable scope;
- indicator match requires asset/exposure validation before escalation;
- one behavior detection works without known indicator;
- endpoint/network telemetry loss is detected;
- evidence access and integrity are controlled;
- rule overhead and event volume are measured.

### Failure scenarios

1. IOC match is treated as confirmed compromise.
2. Old/shared IP/domain indicator creates false incident.
3. Expected package/deployment tool triggers every rule.
4. Container event cannot be mapped to Pod/service identity.
5. Packet capture collects unrelated sensitive traffic.
6. Endpoint agent stops and silence is interpreted as health.
7. Rule overhead destabilizes workload.

## Результат для базы знаний

- **Endpoint process, file and privilege telemetry**.
- **Network flow, DNS and TLS security evidence**.
- **Behavior- and indicator-based detections**.
- **Threat-intelligence confidence and applicability**.
- **Endpoint/network telemetry scope and integrity**.

## Когда переходить дальше

Можно переходить, когда host/network events distinguish synthetic malicious behavior from legitimate operations and indicator confidence is handled explicitly.