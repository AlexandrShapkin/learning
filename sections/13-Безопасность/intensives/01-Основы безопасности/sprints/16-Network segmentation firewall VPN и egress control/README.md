# Спринт 16. Network segmentation, firewall, VPN и egress control

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как ограничить сетевые пути так, чтобы каждый workload мог обращаться только к необходимым сервисам, а обход security controls был заметен?

## Результат спринта

После завершения необходимо уметь:

- inventory ingress, egress and lateral flows;
- distinguish segmentation, filtering and encryption;
- design default-deny firewall/network policies;
- restrict administrative access through dedicated paths;
- apply egress allowlists and DNS/proxy considerations;
- understand VPN and tunnel trust boundaries;
- protect metadata/internal endpoints from unintended reachability;
- handle asymmetric routes and stateful firewall behavior;
- log denied/allowed flows proportionately;
- test segmentation without uncontrolled scanning;
- preserve emergency management path.

## Основной маршрут

1. Draw required network-flow matrix.
2. Implement namespace/container/Kubernetes default deny.
3. Allow only exact application dependencies.
4. Add administrative VPN/tunnel path.
5. Restrict egress and test DNS/provider fallback behavior.

## Лабораторная работа

Создать `work/network-security/`.

### Requirements

- flow matrix names source, destination, protocol, port and purpose;
- unlisted ingress, egress and lateral traffic is denied;
- admin endpoints are unreachable from user/application networks;
- service identity/authorization is not replaced by IP filtering;
- DNS and proxy paths cannot bypass egress policy silently;
- denied-flow evidence is rate-limited and attributable;
- management access remains available through one protected path;
- policy changes are versioned and tested;
- packet capture confirms intended encrypted/plaintext boundaries.

### Failure scenarios

1. Flat internal network permits lateral access.
2. Backend bypasses reverse proxy/authentication.
3. Egress allows arbitrary internet or metadata endpoint.
4. DNS/proxy path bypasses destination control.
5. VPN grants unrestricted network trust.
6. Firewall change removes management access.
7. Excessive deny logging causes resource exhaustion.

## Результат для базы знаний

- **Network segmentation and default-deny policy**.
- **Ingress, egress and lateral-flow controls**.
- **Administrative network access and VPN boundaries**.
- **Egress filtering and metadata protection**.
- **Network-policy validation and evidence**.

## Когда переходить дальше

Можно переходить, когда every permitted flow is justified and direct/bypass/lateral paths are denied without losing controlled administration.