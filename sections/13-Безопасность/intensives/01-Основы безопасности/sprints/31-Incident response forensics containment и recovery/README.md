# Спринт 31. Incident response, forensics, containment и recovery

Ориентировочный объём: 21–31 час.

## Центральный вопрос

Как подтвердить security incident, сохранить evidence, ограничить ущерб и восстановить доверие without destroying the information needed to understand what happened?

## Результат спринта

После завершения необходимо уметь:

- distinguish event, alert, incident and breach;
- define severity, scope and incident roles;
- preserve volatile and durable evidence with chain-of-custody concepts;
- build timeline from identity, host, network, application and control-plane sources;
- identify initial access, persistence, privilege and affected assets conceptually;
- contain accounts, tokens, workloads, network paths and data access;
- distinguish containment, eradication and recovery;
- rotate credentials and rebuild trusted state;
- verify no stale sessions, artifacts or persistence remain;
- communicate uncertainty and affected data honestly;
- produce post-incident corrective actions and detection improvements;
- handle legal/privacy escalation as organizational dependency.

## Основной маршрут

1. Trigger a synthetic credential/application compromise scenario.
2. Triage alerts and declare incident scope/severity.
3. Preserve evidence before restart/redeployment.
4. Contain identities, network and workloads.
5. Rebuild/restore, rotate credentials and validate trust.
6. Produce timeline and corrective-action plan.

## Лабораторная работа

Создать `work/security-incident-response/`.

### Requirements

- incident record separates facts, hypotheses and decisions;
- evidence records source, time, collector, hash and access;
- containment is scoped and reversible where possible;
- compromised credentials/sessions/certificates are revoked/rotated;
- immutable artifact and known-good configuration are used for recovery;
- affected data and unauthorized actions are quantified from evidence;
- recovery includes heightened monitoring and validation period;
- stale access, persistence and vulnerable path are checked;
- communication includes known, unknown, impact and next update;
- corrective actions map to control, owner and verification.

### Failure scenarios

1. System is restarted before volatile evidence is preserved.
2. One account is disabled but active tokens/certificates remain.
3. Compromised image/config is redeployed during recovery.
4. Broad network shutdown destroys evidence and causes unrelated outage.
5. Timeline relies on unsynchronized/untrusted logs without caveat.
6. Root cause is declared before competing hypotheses are tested.
7. Service returns while original vulnerable path remains.
8. Evidence bundle contains secrets or unrelated personal data.

## Результат для базы знаний

- **Security incident lifecycle and severity**.
- **Digital evidence preservation and chain of custody**.
- **Security-incident timelines and scope**.
- **Containment, eradication and trusted recovery**.
- **Credential rotation and post-incident corrective actions**.

## Когда переходить дальше

Можно переходить, когда a synthetic compromise is contained and recovered with preserved evidence, revoked access and verified removal of the enabling path.