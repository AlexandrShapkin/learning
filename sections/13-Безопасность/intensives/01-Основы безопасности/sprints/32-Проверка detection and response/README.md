# Спринт 32. Проверка detection and response

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 27–31.

## Исходная задача

Создать `work/detection-response-checkpoint/` — vulnerability-to-detection-to-response route with normalized findings, security events, host/network detections, incident evidence, containment and trusted recovery.

## Required capabilities

- asset/vulnerability inventory and prioritization;
- SAST/DAST/fuzz findings with regression tests;
- security event catalogue and detection rules;
- endpoint/network telemetry and enrichment;
- detection tests and suppression lifecycle;
- incident declaration, evidence preservation and timeline;
- identity/workload/network containment;
- credential rotation and trusted rebuild;
- remediation and corrective-action verification.

## Mandatory fault cases

1. High-severity scanner finding is not exposed/reachable.
2. Lower-severity issue has public/admin impact and is urgent.
3. Source is fixed but old vulnerable artifact remains deployed.
4. Security log contains token or sensitive payload.
5. Detection depends on missing/broken telemetry.
6. Noisy rule hides meaningful event.
7. IOC is old/shared and creates false incident.
8. Endpoint agent stops silently.
9. Compromised credential retains refresh/session/certificate access.
10. Restart destroys volatile evidence.
11. Recovery redeploys compromised artifact/configuration.
12. Incident closes before vulnerable path and persistence are verified absent.

## Defense

1. How are findings tied to assets and runtime?
2. How is risk priority determined?
3. Which security events support each detection?
4. How are detections tested and tuned?
5. How is telemetry loss detected?
6. How are indicators and behaviors interpreted?
7. What evidence is preserved before containment?
8. How is chain of custody approximated?
9. Which identities and paths are contained?
10. How is trusted recovery established?
11. How is residual access/persistence checked?
12. Which corrective actions reduce recurrence?

## Критерии прохождения

- findings are normalized, prioritized and verified in runtime;
- detections produce useful evidence with controlled noise;
- telemetry loss/tampering is visible;
- incident evidence survives containment;
- credentials, workloads and paths are contained and recovered;
- all twelve faults are reproduced and corrected;
- at least 10 of 12 defense answers cite findings, events, hashes or timelines;
- cleanup removes synthetic indicators, captures, credentials and evidence secrets.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update detection/IR notes where exercises changed evidence or response assumptions.