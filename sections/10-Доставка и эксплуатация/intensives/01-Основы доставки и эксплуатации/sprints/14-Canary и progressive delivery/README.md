# Спринт 14. Canary и progressive delivery

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как expose a new revision to increasing risk in controlled steps, using meaningful analysis and stop criteria rather than percentage-based theater?

## Результат спринта

После завершения необходимо уметь:

- distinguish canary deployment, canary release and shadow traffic;
- select representative cohorts and traffic weights;
- define baseline and candidate comparison;
- choose metrics tied to user/system risk;
- set observation windows, minimum samples and guardrails;
- understand false positives/negatives and noisy metrics;
- automate pause, continue, abort and promotion;
- separate canary infrastructure health from product correctness;
- handle background jobs and stateful effects;
- avoid duplicate external side effects in shadowing;
- compare controller-driven and pipeline-driven progressive delivery;
- design manual judgment for risks metrics cannot capture.

## Основной маршрут

1. Introduce one known latency/error regression.
2. Route 1%, 10%, 50% and 100% traffic with pauses.
3. Compare candidate against stable baseline.
4. Abort automatically on one guardrail and continue on healthy release.
5. Test cohort-based release and shadow-read-only path.

## Лабораторная работа

Создать `work/progressive-delivery/`.

### Requirements

- traffic/candidate identity is verifiable;
- canary receives representative traffic or explicit cohort;
- metrics include availability/error/latency plus one business correctness signal;
- thresholds, sample size and observation window are documented;
- analysis distinguishes candidate from shared dependency failure;
- automatic abort preserves evidence and stops further exposure;
- background workers/external effects are single-owner or idempotent;
- shadow traffic cannot mutate irreversible state;
- manual approval is used only for named non-automatable risk;
- promotion/abort leaves one clear desired revision;
- controller/pipeline state is reconciled after interruption.

### Failure scenarios

1. Canary gets only synthetic/easy traffic and misses real defect.
2. Percentage advances before enough samples.
3. Shared database outage is blamed on candidate.
4. Global metric hides severe failure in one tenant/route.
5. Shadow request sends payment/email twice.
6. Canary and stable workers process same queue unsafely.
7. Abort rolls app back but migration/external effect remains.
8. Automated analysis uses noisy threshold and flaps.
9. Manual “looks fine” replaces defined criteria.

## Результат для базы знаний

- **Canary and progressive software delivery**.
- **Progressive-delivery cohorts and traffic weighting**.
- **Canary analysis metrics, windows and guardrails**.
- **Shadow traffic and side-effect safety**.
- **Automated promotion, pause and abort**.

## Когда переходить дальше

Можно переходить, когда a known regression is stopped before full exposure and healthy candidate promotion is driven by representative, candidate-specific evidence with bounded side effects.