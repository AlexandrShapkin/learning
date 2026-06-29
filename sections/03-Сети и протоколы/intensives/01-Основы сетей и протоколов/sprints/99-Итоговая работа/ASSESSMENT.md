# Итоговая проверка

## Blind incident exercise

Решить минимум 12 скрытых сценариев, включая:

- два L2/L3;
- один IPv6;
- один DNS/DHCP;
- два TCP/TLS/HTTP;
- один firewall/NAT/VPN;
- один overlay;
- один performance;
- три combined incidents.

Примеры combined incidents:

- stale DNS + rotated certificate;
- asymmetric route + stateful firewall;
- overlay MTU + HTTP retry;
- backend CPU saturation + health-check flapping;
- broken IPv6 path + valid AAAA;
- log rate limit + wrong capture point.

Для каждого инцидента:

```text
Symptom and impact
Initial safety action
Expected forward/return path
Evidence and timeline
Ranked hypotheses
Discriminating test
Root cause, trigger and secondary effects
Minimal repair
Verification
Rollback
Prevention or detection improvement
```

Raw captures/logs/configs заменяют длинный пересказ.

## Final defense

Ответить с опорой на project evidence:

1. Как application data передаётся end to end?
2. Какие преобразования происходят на каждом layer/hop?
3. Чем роли MAC и IP address отличаются?
4. Как выбирается и разрешается next hop?
5. Как планируются subnets и routes?
6. Чем UDP отличается от TCP?
7. Как TCP устанавливает соединение, восстанавливает loss и закрывается?
8. Как работают DNS resolution, delegation и cache?
9. Как TLS аутентифицирует и защищает traffic?
10. Чем forward proxy, reverse proxy и load balancer отличаются?
11. Как firewall/NAT принимает решение и преобразует traffic?
12. Как VPN и overlay encapsulate packets?
13. Как VM/container/cloud abstractions отображаются на mechanisms?
14. Как локализовать DNS/routing/TCP/TLS/application failure?
15. Какие metrics описывают network health/performance?
16. Как network design влияет на availability, security и performance?

Каждый ответ должен ссылаться минимум на один capture, state table, counter или incident.

## Completion criteria

Интенсив завершён, когда:

- clean VM builds full topology from repository;
- setup and cleanup are repeatable and scoped;
- dual-stack L2/L3, DNS, DHCP, transport, TLS, proxy/LB, firewall/NAT/VPN and overlay paths work;
- applications pass tests and preserve semantics under retries/failures;
- performance baseline and evidence map exist;
- all 50 fault modes are safe and reversible, либо environmental limitation доказана и заменена эквивалентным experiment;
- minimum 12 blind incidents and 3 combined incidents are diagnosed;
- no secrets or unrelated traffic are committed;
- all main section questions are answered through evidence;
- generalized knowledge is transferred to `knowledge`.

## Delayed assessment

Через 7–14 дней без повторного чтения:

1. нарисовать packet path от client process до backend и обратно;
2. ответить на 16 final-defense questions;
3. rebuild или inspect topology from scripts;
4. диагностировать четыре random faults, включая combined;
5. вручную разобрать одну L2/L3/TCP/DNS/TLS sequence;
6. назвать одно architectural improvement, уменьшающее failure probability или diagnostic ambiguity.

После delayed assessment уровень 3–4 можно считать закреплённым.