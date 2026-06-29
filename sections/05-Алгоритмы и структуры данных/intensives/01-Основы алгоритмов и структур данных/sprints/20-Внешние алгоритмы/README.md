# Спринт 20. Внешние алгоритмы

Ориентировочный объём: 16–24 часа.

## Центральный вопрос

Как process data larger than RAM by minimizing block I/O, bounding memory and preserving correctness under partial files and limited temporary storage?

## Результат спринта

После завершения необходимо уметь:

- distinguish RAM model from external-memory/I/O model;
- reason about block size, sequential versus random I/O;
- implement external merge sort;
- choose run size from memory budget;
- perform k-way merge with heap;
- manage temporary files and cleanup;
- stream parse/write without read-all;
- partition data for external hash/group operations;
- understand B-tree relevance to block storage;
- estimate I/O volume and number of passes;
- handle duplicate/stable ordering and record framing;
- resume or safely restart after partial failure;
- enforce disk-space/file-count limits;
- compare GNU sort/SQLite/stdlib as production baselines;
- diagnose memory blow-up, too many runs and random-I/O degradation;
- understand compression/checksum trade-offs.

## Основной маршрут

### Шаг 1. I/O cost model

Use parameters N records, memory M, block B. Sequential transfer and number of passes often dominate comparison count.

### Шаг 2. External merge sort

```text
read bounded chunk → sort in memory → write run
→ open runs → k-way merge via heap → final output
```

Fan-in is limited by memory and file descriptors.

### Шаг 3. Partitioning

Hash-partition records so each partition fits memory, then process individually. Handle skew/hot partitions.

### Шаг 4. Reliability

Use dedicated temp directory, manifest, atomic final rename, checksums/counts and cleanup. Do not overwrite source before final verification.

## Ресурсы

### Обязательный маршрут

- Massive-dataset algorithms external sorting chapters.
- Database systems external sort/hash algorithms overview.
- Go `bufio`, `io`, `os`, `container/heap` docs.
- GNU `sort` documentation as baseline.

### Углубление

- replacement selection;
- polyphase merge;
- LSM trees;
- external graph algorithms;
- compression-aware I/O;
- distributed sorting.

## Практические задания

1. Generate deterministic files exceeding chosen memory budget.
2. Implement run generation and k-way merge.
3. Measure I/O bytes, run count and passes by memory/fan-in.
4. Add stable sort by key+sequence.
5. Implement external distinct/group count through partitioning or sorted stream.
6. Compare with GNU sort under same data contract.

## Лабораторная работа

Создать `work/external-lab/`.

### CLI

```text
extsort generate --records N --seed S --out FILE
extsort sort --memory 128MiB --fan-in 32 IN OUT
extsort distinct --memory ... IN OUT
extsort verify IN OUT
extsort resume MANIFEST
```

### Requirements

- framed or line format with maximum record size;
- memory budget enforced approximately and measured;
- temp directory explicit;
- fan-in respects fd limit;
- multi-pass merge supported;
- counts/checksums/order/permutation verified;
- output committed by atomic rename where filesystem permits;
- interrupted run cleanup/resume policy;
- skew and large-record cases;
- benchmark reports wall time, CPU, max RSS, read/write bytes and passes;
- generated large files ignored by Git.

### Failure scenarios

1. One record exceeds memory/chunk policy.
2. Too many run files/fd exhaustion.
3. Disk full during run/merge.
4. Corrupt/truncated run.
5. Process interrupted before final rename.
6. Unstable equal-key merge.
7. Partition skew exceeds memory.
8. Temp files leak after failure.
9. Read-all accidentally defeats external design.
10. Output verified only for order, not permutation.

## Самопроверка

1. Why Big O comparisons insufficient for external data?
2. What is block/I/O model?
3. External merge sort stages?
4. Why k-way merge uses heap?
5. What limits fan-in?
6. How many passes depend on runs/fan-in?
7. Why sequential I/O preferred?
8. How handle skew in hash partitioning?
9. What makes output commit safe?
10. Why verify permutation/count/checksum?

## Результат для базы знаний

- **External-memory/I/O model**.
- **External merge sort**.
- **Run generation and k-way merge**.
- **External hash partitioning**.
- **Memory, block and file-descriptor constraints**.
- **Temporary-file lifecycle and resumability**.
- **I/O-volume and pass analysis**.

## Когда переходить дальше

Можно переходить, когда data larger than budget is processed within limits, failures leave source intact, and I/O/pass metrics explain performance.