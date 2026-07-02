# Спринт 21. Distributed locks, leases и fencing tokens

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как предоставить временное исключительное право на действие, если holder может остановиться, потерять связь or resume after lease expiration?

## Результат спринта

После завершения необходимо уметь:

- различать mutex, distributed lock and lease;
- понимать lease expiration and renewal uncertainty;
- использовать monotonic fencing token/epoch;
- предотвращать stale holder writes;
- выбирать lock granularity and contention policy;
- handle clock assumptions and pauses;
- design acquisition, renewal, release and timeout;
- avoid relying on client-side release only;
- understand lock service availability and consistency requirements;
- recognize cases where optimistic concurrency or partition ownership is better;
- test split-brain lock holders.

## Основной маршрут

1. Implement lease service or use etcd/Redis comparison.
2. Pause holder beyond expiration.
3. Let new holder acquire higher fencing token.
4. Resume old holder and reject its writes at protected resource.

## Лабораторная работа

Создать `work/locks-leases/`.

### Requirements

- lease has unique holder identity, expiry and renewal rules;
- protected resource validates monotonically increasing fencing token;
- expired holder cannot mutate state after resume;
- renewal failure causes holder to stop before unsafe action where possible;
- acquisition contention is bounded and jittered;
- lock metadata survives/rejects stale process epochs;
- release is idempotent and cannot release another holder’s lease;
- lock-service partition behavior is documented;
- one operation is redesigned without distributed lock.

### Failure scenarios

1. Holder pauses beyond TTL and resumes.
2. Clock skew makes client believe lease is valid.
3. Old process releases new holder’s lock.
4. Lock service loses state after restart.
5. Two clients acquire during partition.
6. Protected database ignores fencing token.
7. Renewal storm overloads lock service.

## Результат для базы знаний

- **Distributed locks and leases**.
- **Lease expiration and holder uncertainty**.
- **Fencing tokens and stale-writer rejection**.
- **Distributed lock-service requirements**.
- **Coordination avoidance alternatives**.

## Когда переходить дальше

Можно переходить, когда a paused stale holder resumes after lease expiry and is rejected by the protected resource, not merely by the lock client.