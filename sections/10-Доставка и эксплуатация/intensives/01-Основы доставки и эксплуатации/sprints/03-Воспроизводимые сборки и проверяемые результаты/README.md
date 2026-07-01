# Спринт 03. Воспроизводимые сборки и проверяемые результаты

Ориентировочный объём: 17–24 часа.

## Центральный вопрос

Как доказать, что declared source and inputs produce the intended artifact, and distinguish byte reproducibility, functional equivalence and trustworthy verification?

## Результат спринта

После завершения необходимо уметь:

- различать deterministic and reproducible builds;
- понимать byte-for-byte versus functional reproducibility;
- normalise timestamps, paths, ordering and archive metadata;
- embed version/build metadata deliberately;
- create checksums and compare artifacts;
- use isolated builders and independent rebuilds;
- understand cross-compilation and platform variance;
- verify binaries and OCI images by digest;
- separate build and test outputs;
- diagnose reproducibility differences;
- avoid signing an artifact before final bytes are known;
- design a release artifact manifest.

## Основной маршрут

1. Build the same binary twice on one machine and compare bytes/metadata.
2. Repeat in two clean builders with pinned toolchain.
3. Build OCI image twice and inspect layer/config timestamp differences.
4. Create artifact manifest with source, dependencies, builder, digest and platform.

## Ресурсы

- reproducible-builds project documentation;
- Go build flags and build information docs;
- OCI image metadata and BuildKit reproducibility references.

## Лабораторная работа

Создать `work/reproducible-builds/`.

### Requirements

- binary build records exact source and toolchain;
- timestamps, paths and archive ordering are controlled;
- two clean builders produce equal bytes or a documented unavoidable variance;
- stripped/debug variants are separate named artifacts;
- build metadata endpoint matches manifest without introducing uncontrolled time;
- OCI image is referenced by digest;
- artifact manifest includes checksum, platform and dependency/source references;
- independent verifier rebuilds or validates artifact;
- mismatch report identifies first differing metadata/content region;
- final signing step occurs after artifact immutability.

### Failure scenarios

1. Embedded current timestamp changes every build.
2. Absolute workspace path leaks into binary/debug data.
3. Archive/file iteration order differs.
4. Builder silently downloads newer base image by mutable tag.
5. Cross-platform outputs are compared as if identical.
6. Artifact is modified/compressed after checksum/signature.
7. Build metadata reports release tag not matching source commit.
8. “Reproducible” means only tests passed twice.

## Самопроверка

1. Deterministic versus reproducible build?
2. Byte versus functional reproducibility?
3. Common nondeterministic inputs?
4. Independent rebuild provides what?
5. Artifact digest identifies what?
6. Build metadata should contain what?
7. Cross-platform variance?
8. Why sign only final bytes?
9. How localize artifact difference?
10. What belongs in artifact manifest?

## Результат для базы знаний

- **Deterministic and reproducible software builds**.
- **Byte and functional reproducibility**.
- **Build metadata and artifact manifests**.
- **Independent rebuild verification**.
- **Artifact checksums and immutable bytes**.

## Когда переходить дальше

Можно переходить, когда two isolated builders produce identical or fully explained outputs and every release artifact has a verifiable manifest tied to exact source and toolchain.