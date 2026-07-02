# Спринт 02. Threat modeling, trust boundaries и attack surface

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Где система переходит между уровнями доверия и какие пути позволяют нарушить её свойства?

## Результат спринта

После завершения необходимо уметь:

- строить data-flow diagrams and trust boundaries;
- определять entry points, assets, actors and dependencies;
- применять STRIDE or equivalent prompt framework without reducing analysis to labels;
- inventory attack surface across code, network, identity and supply chain;
- identify abuse cases and privilege transitions;
- model data flows, stores and external services;
- prioritize threats by feasibility and impact;
- translate threats into requirements and tests;
- maintain threat model through architecture changes.

## Основной маршрут

1. Draw context and container-level DFDs.
2. Mark identities, data stores, trust zones and external dependencies.
3. Enumerate abuse cases for each boundary.
4. Map controls and unresolved threats.
5. Change one architecture element and update the model.

## Лабораторная работа

Создать `work/threat-model/`.

### Requirements

- diagrams show data direction, protocol, identity and sensitivity;
- every trust boundary has authentication, authorization and validation expectations;
- attack surface includes debug/admin endpoints, CI/CD and third parties;
- at least twenty threats are documented with preconditions and impact;
- mitigations map to owners and verification;
- accepted/unresolved threats are visible;
- one threat is removed by architecture simplification;
- model revision is linked to the changed design.

### Failure scenarios

1. Diagram omits admin or background paths.
2. Internal network is considered trusted automatically.
3. STRIDE labels have no concrete scenario.
4. Third-party dependency and CI token are absent.
5. Mitigation says only “validate input”.
6. Threat model becomes stale after new integration.

## Результат для базы знаний

- **Threat modeling and data-flow diagrams**.
- **Trust boundaries and privilege transitions**.
- **Attack-surface inventory**.
- **Abuse cases and security requirements**.
- **Threat-model lifecycle**.

## Когда переходить дальше

Можно переходить, когда every significant flow and trust transition has concrete threats, controls and verification paths.