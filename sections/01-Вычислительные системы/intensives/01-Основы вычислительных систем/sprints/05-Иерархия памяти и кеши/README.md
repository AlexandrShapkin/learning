# Спринт 05. Иерархия памяти и кеши

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Почему скорость программы зависит не только от количества инструкций, но и от расположения и порядка доступа к данным?

## Результат спринта

После завершения необходимо уметь:

- объяснять иерархию registers → caches → DRAM → storage;
- различать latency, bandwidth и capacity;
- объяснять temporal и spatial locality;
- описывать cache line, set, way, tag, hit и miss;
- различать compulsory, capacity и conflict misses;
- объяснять write-through/write-back и write-allocate/no-write-allocate;
- обнаруживать границы уровней кеша экспериментально;
- проектировать benchmark, не удаляемый compiler optimization;
- объяснять влияние layout, stride и traversal order;
- отличать CPU cache от OS page cache и application cache.

## Место в интенсиве

Машинные инструкции обращаются к памяти не напрямую с одинаковой стоимостью. Этот спринт показывает физическую и микроархитектурную сторону памяти; следующий добавит виртуальные адреса и paging.

## Основной маршрут

### Шаг 1. Иерархия хранения

Прочитать CS:APP 6.1–6.3. Составить таблицу собственных устройств: примерная capacity, access latency, bandwidth и persistence. Не смешивать latency одной операции с aggregate throughput.

### Шаг 2. Locality и caches

Прочитать CS:APP 6.4–6.6. Разобрать:

- cache addressing `S`, `E`, `B`;
- decomposition address into tag/set/block offset;
- direct-mapped и set-associative caches;
- replacement и write policies;
- locality в multidimensional arrays.

### Шаг 3. Реальная машина

Исследовать:

```bash
lscpu
find /sys/devices/system/cpu/cpu0/cache -maxdepth 2 -type f -print -exec cat {} \;
getconf LEVEL1_DCACHE_SIZE
getconf LEVEL2_CACHE_SIZE
getconf LEVEL3_CACHE_SIZE
```

Некоторые files или `getconf` values могут отсутствовать. Источником истины является доступная hardware/kernel information, а не ожидание конкретной topology.

### Шаг 4. Hardware counters

Прочитать обзор `perf stat`:

- https://man7.org/linux/man-pages/man1/perf-stat.1.html
- https://man7.org/linux/man-pages/man1/perf-list.1.html

Доступность cache events зависит от CPU, kernel policy и virtualization. Невозможность получить event фиксируется как limitation, а не обходится выдуманным числом.

## Ресурсы

### Обязательный маршрут

- CS:APP 3e, глава 6.
- CS61C notes по caches: https://notes.cs61c.org/
- `lscpu(1)`, Linux cache sysfs.

### Альтернативные объяснения

- Patterson & Hennessy, Memory Hierarchy.
- Ulrich Drepper, «What Every Programmer Should Know About Memory»: https://people.freebsd.org/~lstewart/articles/cpumemory.pdf
- Intel optimization manual через Intel manuals page.

### Углубление

- cache coherence и MESI;
- hardware prefetching;
- inclusive/exclusive caches;
- NUMA и memory controllers;
- Agner Fog microarchitecture manuals: https://www.agner.org/optimize/

### Справочные материалы

- Intel SDM performance monitoring chapters.
- `perf_event_open(2)`.

## Практические задания

### 1. Адрес в учебном кеше

Для cache с parameters:

```text
address width = 16 bits
S = 8 sets
E = 2 ways
B = 16 bytes
```

Для адресов `0x0000`, `0x000f`, `0x0010`, `0x0080`, `0x0180`, `0x1084` вручную определить tag, set index и block offset.

Затем смоделировать последовательность accesses и отметить hit/miss с LRU replacement.

### 2. Layout структур

Для Go-структуры:

```go
type Record struct {
    Active bool
    Count  int64
    Code   uint16
    Score  float64
}
```

Получить `unsafe.Sizeof`, `unsafe.Alignof` и offsets. Предложить перестановку fields, уменьшающую padding, проверить фактически и объяснить, когда уменьшение object size влияет на cache behavior.

### 3. Matrix traversal

Создать квадратную matrix минимум 4096×4096 элементов `int32`. Сравнить row-major и column-major sum. До измерения предсказать разницу и связать её с cache line usage.

## Лабораторная работа

Создать `work/cachebench/` на Go.

### Нагрузки

1. `sequential`: последовательный обход массива.
2. `stride`: обход с configurable stride.
3. `random`: pointer-chasing по заранее перемешанной permutation, чтобы уменьшить пользу prefetcher.
4. `matrix`: row-major, column-major и tiled traversal.

### Размеры

Использовать powers of two от 4 KiB до размера, который минимум вдвое превышает LLC, но не превышает разумную долю RAM. Скрипт должен определять верхнюю границу или принимать её parameter; запрещено безусловно выделять гигабайты.

### Методика

- `GOMAXPROCS=1`;
- запуск через `taskset -c <cpu>` при наличии;
- отдельный warm-up;
- минимум 7 измерений каждого варианта;
- фиксированный seed random permutation;
- результат computation используется, чтобы compiler не удалил работу;
- вывод raw samples и median ns/access;
- отдельно вычисляется effective bandwidth для sequential workload.

### Проверка

```bash
go test ./...
go test -bench . -benchmem -count 7 ./...
perf stat -e cycles,instructions,cache-references,cache-misses -- ./cachebench ...
```

`perf`-команда является обязательной попыткой, но hardware events могут быть недоступны. В таком случае сохранить точную ошибку и продолжить по timing data.

### Ожидаемый результат

График или CSV должен показывать хотя бы часть следующих эффектов:

- рост cost при выходе working set за cache level;
- ухудшение при большом stride;
- random pointer chasing медленнее streaming access;
- column-major traversal хуже row-major;
- tiled traversal возвращает часть locality.

Нельзя подгонять conclusion, если конкретная VM скрыла границы. Тогда изменить environment или объяснить limitation.

## Дополнительный эксперимент

Для matrix multiplication реализовать naive `i-j-k` и blocked version с tile sizes 8, 16, 32, 64. Не требуется оптимальная реализация. Найти tile size, лучший на своей машине, и объяснить, почему результат нельзя переносить на любой CPU.

## Самопроверка

1. Почему маленький cache может ускорять доступ к большой памяти?
2. Чем cache line отличается от page?
3. Почему sequential access использует bandwidth лучше random access?
4. Почему увеличение associativity уменьшает одни misses, но не другие?
5. Как prefetcher может исказить microbenchmark?
6. Почему «данные в кеше» не является стабильным свойством переменной?
7. Чем CPU cache отличается от page cache?

Практическая проверка: по CSV без подписей определить, какая серия вероятнее всего является sequential, strided и random, и обосновать по форме данных.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Иерархия памяти** — levels, latency, bandwidth и capacity.
- **Процессорный кеш** — lines, sets, ways, tags, policies и misses.
- **Локальность данных** — temporal/spatial locality и связь с layout.
- **Аппаратная предвыборка** — цель, ограничения и влияние на measurements.
- **Выравнивание и padding** — alignment, object layout и cache footprint.
- **Пропускная способность памяти** — отличие от access latency.

Связать заметки с processor, virtual memory и performance measurement.

## Когда переходить дальше

Можно переходить, когда cache benchmark воспроизводится одной командой, raw samples сохранены, наблюдаемый эффект объясняется через locality/cache lines, а ограничения конкретной машины явно отделены от общего механизма.