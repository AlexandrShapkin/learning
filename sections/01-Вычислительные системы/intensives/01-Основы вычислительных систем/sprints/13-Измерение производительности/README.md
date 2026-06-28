# Спринт 13. Измерение производительности

Ориентировочный объём: 12–16 часов.

## Центральный вопрос

Как доказательно определить ограничивающий ресурс программы и проверить, что изменение действительно улучшило нужный workload?

## Результат спринта

После завершения необходимо уметь:

- формулировать performance question и hypothesis;
- различать latency, throughput, utilization, saturation и errors;
- строить reproducible benchmark;
- учитывать warm-up, variance, sample count и environment;
- использовать `time`, `perf stat`, `perf record`, Go benchmarks, pprof и trace;
- различать CPU-bound, memory-bound, I/O-bound и lock-bound workload;
- находить hot functions, allocations, cache misses, syscalls и contention;
- использовать baseline и correctness tests;
- применять Amdahl's law к ожидаемому ускорению;
- избегать common benchmark errors;
- документировать только существенные условия и evidence.

## Место в интенсиве

Предыдущие спринты изучили отдельные ресурсы. Теперь они объединяются в методику: сначала вопрос и baseline, затем измерение, локализация bottleneck, изменение и повторная проверка.

## Основной маршрут

### Шаг 1. Program optimization

Прочитать CS:APP chapter 5. Обратить внимание на:

- eliminating loop inefficiencies;
- reducing procedure calls;
- memory references;
- instruction-level parallelism;
- branch prediction;
- limiting factors.

Не переносить примеры оптимизации без измерения на собственный workload.

### Шаг 2. Методика

Изучить USE method обзорно по *Systems Performance*: для каждого ресурса искать utilization, saturation и errors.

Для каждого experiment заранее записывать:

- question;
- workload;
- metric;
- controlled variables;
- expected direction;
- stopping criterion.

### Шаг 3. Linux perf

Изучить:

- `perf(1)`: https://man7.org/linux/man-pages/man1/perf.1.html
- `perf stat`;
- `perf record/report/annotate`;
- workload tracing guide: https://docs.kernel.org/admin-guide/workload-tracing.html

### Шаг 4. Go profiling

Изучить:

- `runtime/pprof`: https://pkg.go.dev/runtime/pprof
- profiling Go programs: https://go.dev/blog/pprof
- diagnostics: https://go.dev/doc/diagnostics
- execution traces: https://go.dev/blog/execution-traces-2024

## Ресурсы

### Обязательный маршрут

- CS:APP chapter 5.
- `perf` manual and kernel workload tracing guide.
- Go benchmark, pprof и trace documentation.

### Альтернативные объяснения

- Brendan Gregg, *Systems Performance, 2nd Edition*.
- Brendan Gregg Linux performance tools diagrams: https://www.brendangregg.com/linuxperf.html
- Julia Evans, perf/strace/profiling zines как визуальное дополнение.

### Углубление

- PMU events и Top-Down Microarchitecture Analysis;
- eBPF profiling;
- profile-guided optimization;
- statistical benchmarking tools;
- continuous profiling.

### Справочные материалы

- `perf_event_open(2)`.
- Go `testing.B` and benchmark docs.
- `benchstat`: https://pkg.go.dev/golang.org/x/perf/cmd/benchstat

## Практические задания

### 1. Ошибки benchmark

Для каждого случая объяснить defect и исправление:

- один run без warm-up;
- benchmark, результат которого не используется;
- сравнение разных input sizes;
- запуск одновременно с background load;
- average без raw samples;
- изменение compiler flags между variants;
- измерение wall time для операции короче timer resolution;
- вывод «CPU медленный» только по 100% CPU;
- оптимизация функции, занимающей 2% total time.

### 2. Amdahl's law

Рассчитать maximum speedup, если оптимизируемая часть занимает 10%, 40% и 80%, а сама ускоряется в 2, 5 и 20 раз. Затем сравнить с реальным experiment лаборатории.

### 3. Baseline protocol

Создать reusable script, который сохраняет:

- git commit;
- binary hash;
- Go/compiler version;
- kernel и CPU model;
- command line;
- environment variables, влияющие на workload;
- raw timing samples;
- median и distribution;
- profiles/counters.

Скрипт не должен собирать весь environment или секреты.

## Лабораторная работа

Создать `work/perflab/` — Go CLI с одинаковым framework и четырьмя workloads.

### Workload A. CPU

Выполняет deterministic calculation над фиксированным input. Начальный вариант должен содержать повторно вычисляемую дорогую функцию внутри loop.

### Workload B. Memory

Обрабатывает большой набор records. Начальный вариант хранит array-of-structs и читает небольшой subset fields; optimized variant может использовать structure-of-arrays или изменить traversal.

### Workload C. Allocations

Парсит records из text/binary input. Начальный вариант создаёт лишние temporary strings/slices. Оптимизация должна уменьшить allocations без изменения result.

### Workload D. Contention

Несколько goroutines обновляют shared metrics через один mutex. Варианты: sharding, batching или ownership goroutine.

### Обязательные этапы для каждого workload

1. Correctness test.
2. Baseline benchmark минимум 10 samples.
3. `pprof` CPU и/или heap/mutex profile.
4. `perf stat` минимум cycles, instructions, branches, branch-misses, cache-misses, context-switches — только доступные events.
5. Hypothesis с ожидаемым metric change.
6. Одно targeted изменение.
7. Повторный benchmark тем же protocol.
8. `benchstat` или эквивалентное сравнение.
9. Проверка, что bottleneck не просто переместился.

### Ограничения

- Не делать несколько независимых оптимизаций одним commit.
- Не удалять correctness work.
- Не использовать unsafe только ради числа без отдельного обоснования.
- Не считать уменьшение allocations самоцелью, если end-to-end metric не улучшилась.
- Не сравнивать debug и optimized binaries.

### Ожидаемый результат

Для каждого workload сохранить краткую карточку в `results/`:

```text
Question
Baseline
Evidence
Change
Result
Limits
```

Это не дневник; достаточно 5–10 строк и ссылок на raw data/profile.

## Дополнительный эксперимент

Выбрать одно успешное улучшение и проверить его:

- на другом input distribution;
- при `GOMAXPROCS=1` и all CPUs;
- при меньшем/большем working set;
- внутри CPU-limited cgroup.

Определить, остаётся ли optimization полезной или была tuned к одному benchmark.

Дополнительно применить Go PGO к CPU workload и сравнить build с profile-guided optimization по официальной документации: https://go.dev/doc/pgo

## Самопроверка

1. Чем utilization отличается от saturation?
2. Почему high CPU может быть нормой?
3. Как IPC и cache misses помогают классифицировать workload?
4. Почему profile sample percentage не равен точному времени каждой функции?
5. Когда wall-clock важнее CPU time?
6. Зачем сохранять raw samples?
7. Как Amdahl's law ограничивает local optimization?
8. Почему microbenchmark может ухудшить production workload?
9. Что означает «корректный baseline»?

Практическая проверка: получить один profile и один `perf stat` output, сформулировать максимум две hypotheses, выбрать следующую измерительную команду и объяснить, какое различие она должна разрешить.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Методика измерения производительности** — question, baseline, evidence и iteration.
- **Latency, throughput, utilization и saturation** — definitions, units и relations.
- **CPU profiling** — sampling, hot paths и limitations.
- **Memory profiling** — allocations, retained memory и working set.
- **Hardware performance counters** — cycles, instructions, branches, caches и caveats.
- **Benchmark design** — warm-up, variance, controls и reproducibility.
- **Amdahl's law** — предел ускорения и выбор target.
- **Диагностика bottleneck** — CPU, memory, I/O и contention evidence.

## Когда переходить дальше

Можно переходить, когда четыре workloads имеют reproducible baselines, каждое изменение связано с profile/counter evidence, correctness сохранена, а выводы отделяют measured result от assumptions.