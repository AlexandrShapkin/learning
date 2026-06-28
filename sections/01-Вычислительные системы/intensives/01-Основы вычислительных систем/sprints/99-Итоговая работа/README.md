# Спринт 99. Итоговая работа

Ориентировочный объём: 20–30 часов.

## Задача

Создать `systems-lab` — небольшое диагностируемое Go-приложение, которое воспроизводимо нагружает CPU, memory, concurrency и I/O, а затем исследовать его от исходного кода до hardware/resource behavior.

Проект не является production monitoring system. Его цель — доказать связное понимание вычислительной системы.

## Обязательная структура

```text
work/systems-lab/
├── cmd/systems-lab/
├── internal/cpuwork/
├── internal/memwork/
├── internal/iowork/
├── internal/concurrency/
├── internal/report/
├── testdata/
├── scripts/
├── Makefile
├── go.mod
└── README.md
```

`README.md` содержит только запуск, scenarios, known limitations и итоговые evidence. Дневник разработки не нужен.

## Команды приложения

### `systems-lab info`

Выводит:

- build version и commit;
- Go version;
- PID, PPID, UID/GID;
- logical CPU count и `GOMAXPROCS`;
- page size;
- выбранные `/proc/self/status` fields;
- cgroup path и основные limits, если доступны;
- addresses global, heap object, local value и function;
- ELF path текущего executable.

### `systems-lab cpu`

Deterministic CPU workload:

- configurable duration/work units;
- минимум два algorithms с одинаковым result;
- single-thread и parallel modes;
- correctness checksum;
- optional CPU profile.

Один variant намеренно содержит повторное вычисление или branch-heavy pattern, чтобы profile позволял targeted optimization.

### `systems-lab memory`

Поддерживает:

- working-set size;
- sequential, strided и random pointer-chasing patterns;
- read и read/write modes;
- configurable stride;
- controlled allocation/release;
- output ns/access и effective bandwidth;
- optional memory/heap profile.

Default size безопасен и не превышает 256 MiB.

### `systems-lab io`

Поддерживает:

- generate deterministic test file;
- copy/scan workloads;
- buffer sizes 1 byte, 4 KiB, 64 KiB, 1 MiB;
- buffered и mmap mode;
- optional `fsync` policy;
- SHA-256 correctness;
- output bytes, duration, throughput и syscall-friendly summary.

Работает только с явно указанными files/directories.

### `systems-lab concurrency`

Поддерживает scenarios:

- unsafe counter с ожидаемой race;
- mutex counter;
- atomic counter;
- owner/channel counter;
- deterministic deadlock demo с timeout и goroutine dump;
- false-sharing pair с padded/unpadded layout.

Unsafe/deadlock modes должны быть отделены от normal tests и запускаться явным flag.

### `systems-lab serve`

Минимальный local HTTP server только для длительного наблюдения:

- `/health`;
- `/work/cpu`;
- `/work/memory`;
- `/debug/pprof/`;
- graceful shutdown.

Server слушает localhost по умолчанию. Аутентификация и production deployment не входят в задачу.

## Функциональные требования

1. Все безопасные modes имеют tests.
2. Outputs machine-readable через optional JSON.
3. Random workloads принимают seed.
4. Errors не игнорируются.
5. Memory/file sizes имеют safe defaults и explicit upper bounds.
6. Build воспроизводится `make build`.
7. `make test`, `make race`, `make bench` и `make clean` работают.
8. Generated large files, profiles и VM images не коммитятся.
9. Приложение корректно завершает goroutines и закрывает files.
10. Каждый workload содержит correctness value, чтобы compiler/runtime не могли удалить полезную работу.

## Этап 1. Проектирование

До реализации создать в README краткую architecture section:

- command boundaries;
- data flow;
- shared state ownership;
- measurement points;
- unsafe scenarios isolation;
- expected artifacts.

Не требуется UML. Достаточно одной diagram Mermaid или text.

## Этап 2. Реализация и tests

Реализовать команды по очереди. После каждой:

- correctness tests;
- one reproducible example;
- failure handling;
- no unrelated refactoring.

Для concurrency обязательно `go test -race ./...` safe packages.

## Этап 3. Binary analysis

Для release binary:

```bash
file systems-lab
readelf -h -S -l -d systems-lab
nm systems-lab
go tool nm systems-lab
go tool objdump -s '<selected symbol>' systems-lab
```

Определить:

- ELF type и architecture;
- entry point;
- static/dynamic dependencies;
- main sections/segments;
- symbol selected workload;
- calling/stack behavior одного function;
- effect `-s -w` и PIE build на size/symbols/addresses.

## Этап 4. Memory analysis

Для `serve` и `memory`:

- сохранить `/proc/$PID/maps`, `smaps_rollup`, status;
- сопоставить code, heap, stacks, libraries и mappings;
- провести reserve/touch experiment;
- измерить page faults;
- сравнить sequential/stride/random;
- подтвердить влияние working set/cache boundaries;
- снять heap profile и отличить allocated от retained.

## Этап 5. Execution and syscalls

Использовать:

```bash
strace -f -c
strace -f -e trace=%file,%process,%memory,%desc
perf stat
```

Для `io` сравнить 1-byte и 64-KiB buffers. Для `serve` проследить process/threads/descriptors. Объяснить every dominant syscall category.

## Этап 6. Concurrency diagnosis

1. Запустить unsafe mode под race detector.
2. Воспроизвести deadlock и получить goroutine dump.
3. Сравнить counter variants по correctness и throughput.
4. Снять mutex/CPU profiles.
5. Проверить false sharing padded/unpadded.
6. Объяснить happens-before safe implementations.

## Этап 7. Performance investigation

Для CPU, memory, I/O и concurrency workload:

- сформулировать question;
- сохранить baseline;
- снять профиль/counters;
- выполнить одно targeted improvement;
- повторить measurements;
- проверить другой input/working-set size;
- применить Amdahl's law к end-to-end effect.

Минимум две оптимизации должны дать измеримый effect, а одна hypothesis может оказаться неверной — это допустимый результат при наличии evidence.

## Этап 8. Isolation

### cgroup

Запустить workloads с CPU и memory limits. Сохранить:

- configured limits;
- `cpu.stat`;
- `memory.current`/`memory.events`;
- application output;
- behavior при controlled limit violation.

### namespace/container

Запустить `info` и один workload внутри `unshare` или container. Сравнить PID, namespace IDs, cgroup, kernel и filesystem view.

### VM

Запустить binary или эквивалентный build внутри QEMU guest. Сравнить CPU information, timings и device model. Cross-compilation допустима, если guest architecture отличается.

## Подготовленные диагностические сценарии

### Сценарий A. Syscall storm

`io --buffer 1` работает корректно, но медленно. Доказать причину через `strace -c`, исправить увеличением buffer и измерить effect.

### Сценарий B. Cache-unfriendly access

`memory --pattern random` или large stride резко увеличивает cost. Связать timing/counters с locality, не оптимизировать изменением semantics.

### Сценарий C. Data race

`concurrency --mode unsafe` даёт nondeterministic result. Получить race report и исправить одним из safe designs.

### Сценарий D. Deadlock

`concurrency --mode deadlock` зависает controlled way. Получить wait evidence и исправить lock order или ownership design.

### Сценарий E. Memory pressure

`memory --retain` удерживает chunks до configurable safe maximum. Под memory cgroup показать growth и limit event; затем исправить lifecycle/reuse. Нельзя намеренно истощать host memory вне strict limit.

### Сценарий F. CPU throttling

CPU workload под quota показывает throttling. Связать wall time с `cpu.stat`, не называть это «медленным процессором».

## Итоговые артефакты

Обязательны:

- source и tests;
- Makefile/scripts;
- small test fixtures;
- benchmark raw data в разумном объёме;
- selected profiles, если они небольшие, либо commands для генерации;
- один `README.md` с reproduction и conclusions;
- одна system diagram;
- ссылки на созданные/обновлённые заметки `knowledge`.

Не коммитить binaries, large inputs, VM images, полный `perf.data`, core dumps и generated caches.

## Итоговая защита

Самостоятельно ответить на основные вопросы раздела:

1. Как информация представляется внутри компьютера?
2. Как processor выполняет machine instructions?
3. Чем physical memory отличается от virtual memory?
4. Где находятся данные выполняющейся программы?
5. Чем process отличается от thread и goroutine?
6. Как программа обращается к operating system?
7. Что происходит при file read и device I/O?
8. Почему возникают races и deadlocks?
9. Как hardware limits влияют на performance?
10. Какие mechanisms лежат в основе VM и containers?

Каждый ответ должен ссылаться минимум на одно наблюдение итогового проекта.

## Критерии завершения интенсива

Интенсив завершён, когда:

- safe functionality проходит tests и race detector;
- все workloads воспроизводимы одной командой;
- binary, mappings, syscalls и resource use исследованы;
- минимум четыре prepared failures диагностированы evidence;
- performance changes проверены повторными measurements;
- cgroup/namespace и VM experiments выполнены либо hardware limitation явно подтверждена;
- основные вопросы раздела отвечаются через mechanisms и project evidence;
- общие знания перенесены в `knowledge` без копирования личных raw results.

## Отложенная проверка

Через 7–14 дней без повторного чтения:

1. нарисовать путь `source → CPU/memory/device`;
2. объяснить десять основных вопросов;
3. воспроизвести один binary/memory/syscall analysis;
4. диагностировать один randomly selected prepared scenario.

После этой проверки уровень интенсива можно считать закреплённым.