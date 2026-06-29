# Спринт 06. OCI-образы, слои и воспроизводимые сборки

Ориентировочный объём: 17–25 часов.

## Центральный вопрос

Как source and build inputs become a content-addressed OCI image, and how to make image size, provenance, compatibility and runtime defaults explicit?

## Результат спринта

После завершения необходимо уметь:

- понимать OCI image manifest, config, layers and indexes;
- различать tag and digest;
- объяснять content-addressed storage and layer reuse;
- проектировать Dockerfile/Containerfile ordering for cache correctness;
- использовать multi-stage builds;
- фиксировать base image by digest where reproducibility requires it;
- минимизировать build context and secret leakage;
- различать build-time and runtime dependencies;
- задавать user, workdir, entrypoint, cmd and health semantics;
- создавать multi-platform image conceptually/practically;
- генерировать SBOM and scan vulnerabilities critically;
- понимать signatures/provenance at practical level;
- избегать mutable package indexes and unpinned downloads;
- проверять image metadata without running it;
- проектировать image update and retirement lifecycle.

## Основной маршрут

1. Build one Go service with naive and multi-stage images.
2. Inspect layers, config, history, tar contents and digests.
3. Reorder instructions and measure cache hit/miss behavior.
4. Build as non-root with minimal runtime filesystem.
5. Push to local registry, pull by tag and digest, then mutate tag.

## Ресурсы

- OCI Image and Distribution specifications.
- Docker/BuildKit build docs.
- image inspection, SBOM, signature and provenance tool docs.

## Лабораторная работа

Создать `work/oci-images/`.

### Requirements

- application build is reproducible from locked source dependencies;
- image has at least naive, improved and distroless/scratch-like variants where applicable;
- base/runtime assumptions are documented;
- build context excludes VCS, secrets, caches and artifacts;
- build secrets do not persist in layers/history;
- runtime user is non-root;
- writable paths are explicit;
- tag/digest behavior is demonstrated with local registry;
- SBOM generated and vulnerability findings triaged by actual reachability/version;
- image labels include source/revision/build metadata without secrets;
- multi-architecture manifest is inspected or built;
- cleanup prunes only labeled lab images and registry data.

### Failure scenarios

1. Secret is removed in later layer but remains in earlier layer.
2. `latest` tag changes silently.
3. Package install/update produces nondeterministic contents.
4. Entire repository becomes build context and invalidates cache/leaks files.
5. Build tools remain in runtime image.
6. Container runs as root with broad writable filesystem.
7. Entrypoint prevents signal/argument behavior expected by runtime.
8. Vulnerability count is treated as risk without package/use/context.
9. Image is “small” but lacks required certificates/timezone/runtime files.

## Самопроверка

1. Manifest, config and layers?
2. Tag versus digest?
3. Layer cache invalidation?
4. Multi-stage build purpose?
5. Build context and secret leakage?
6. Entrypoint versus command?
7. Why non-root and read-only rootfs?
8. SBOM versus vulnerability scanner?
9. Signature/provenance provide what?
10. Reproducible image limitations?

## Результат для базы знаний

- **OCI image structure and content addressing**.
- **Container image tags and digests**.
- **Layer caching and multi-stage builds**.
- **Container build context and secret handling**.
- **Runtime image user, entrypoint and filesystem contract**.
- **SBOM, signatures and image provenance**.

## Когда переходить дальше

Можно переходить, когда the same source produces an inspectable minimal image, deployment can pin a digest, and no credential/build-only dependency is present in runtime layers.