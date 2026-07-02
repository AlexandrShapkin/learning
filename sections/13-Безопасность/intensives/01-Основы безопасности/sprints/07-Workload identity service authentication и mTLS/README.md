# Спринт 07. Workload identity, service authentication и mTLS

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как сервисы доказывают свою идентичность и получают краткоживущий доступ без общих статических секретов?

## Результат спринта

После завершения необходимо уметь:

- distinguish user, machine and workload identity;
- bind identity to workload/environment/instance;
- issue short-lived certificates or tokens;
- use mTLS for mutual authentication where appropriate;
- validate peer name, trust domain and certificate chain;
- rotate workload credentials without downtime;
- avoid shared API keys and embedded secrets;
- authorize service-to-service actions separately from authentication;
- handle bootstrap trust and identity issuance;
- revoke/disable compromised workload identity;
- understand SPIFFE-like trust-domain concepts.

## Основной маршрут

1. Assign separate identities to API, worker and CI.
2. Issue short-lived local certificates.
3. Enforce mTLS on one internal path.
4. Add service authorization policy.
5. Rotate CA/intermediate/workload certificates and revoke one service.

## Лабораторная работа

Создать `work/workload-identity/`.

### Requirements

- each workload has distinct identity and least-privilege policy;
- credentials are short-lived and not stored in image/repository;
- peer validation checks trust domain and expected service identity;
- certificate rotation overlaps safely and removes old trust afterward;
- compromised identity can be disabled without rotating unrelated services;
- bootstrap issuance is protected and audited;
- workload rescheduling creates a new instance identity where appropriate;
- mTLS does not replace application authorization;
- failed authentication and policy decisions generate safe events.

### Failure scenarios

1. All services share one API key/certificate.
2. Client accepts any certificate signed by broad CA without name check.
3. Certificate expires and causes full outage.
4. Old CA remains trusted indefinitely after rotation.
5. Compromised worker identity can call admin API.
6. Workload credential is baked into container image.
7. Sidecar/proxy identity is confused with application identity.

## Результат для базы знаний

- **Workload and service identities**.
- **Mutual TLS for service authentication**.
- **Short-lived workload credentials**.
- **Trust domains and peer-name validation**.
- **Workload credential rotation and revocation**.

## Когда переходить дальше

Можно переходить, когда each service authenticates and authorizes independently through short-lived identity and one compromised workload has bounded access.