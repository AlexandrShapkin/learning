# Спринт 18. Проверка релиза и развёртывания

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 09–17.

## Исходная задача

Создать `work/release-deployment-checkpoint/` — release one immutable artifact through dev, staging and production-like environments with configuration/secrets, compatible migration and progressive deployment.

## Required flow

1. Build and sign one release manifest/artifact set.
2. Promote exact digests through three environments.
3. Rotate one configuration and one secret independently.
4. Run expand/backfill/switch/contract migration.
5. Deploy through rolling or blue-green baseline.
6. Progress candidate through canary analysis.
7. Activate feature flag for cohort.
8. trigger failure and choose rollback or roll forward.
9. remove temporary flag/compatibility path.

## Mandatory fault cases

1. Staging and production artifact digests differ.
2. Config schema/version mismatch.
3. Secret rotation leaves stale consumers.
4. Readiness passes before dependency/schema compatibility.
5. Rolling update exceeds capacity or drops active work.
6. Canary metric uses shared/noisy signal.
7. Shadow/canary duplicates external effect.
8. Feature flag defaults/targeting are inconsistent.
9. Migration blocks or misses concurrent changes.
10. Rollback is attempted after irreversible state change.
11. Old worker/client is incompatible with new data/event.
12. Cleanup removes rollback artifact or active environment.

## Defense

1. How is one artifact promoted?
2. Environment parity and meaningful differences?
3. Release manifest and approval scope?
4. Configuration versus secret lifecycle?
5. Rolling/blue-green/canary selection?
6. Canary sample/window/guardrails?
7. Feature flag failure and removal?
8. Mixed-version compatibility?
9. Backfill and concurrent-write reconciliation?
10. Rollback versus roll forward?
11. Post-deploy verification?
12. Cleanup and retention safety?

## Критерии прохождения

- exact artifact digest is preserved through promotion;
- environment/config/secret/schema revisions are visible;
- deployment strategy and capacity assumptions are measured;
- canary stops a known regression and promotes a healthy release;
- migration survives interruption and mixed versions;
- recovery decision preserves data/contracts/external effects;
- all twelve faults are diagnosed;
- temporary compatibility/flag paths are removed;
- cleanup preserves required recovery artifacts;
- at least 10 of 12 defense answers use release/runtime evidence.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update existing notes where rollout or migration evidence changed assumed guarantees.