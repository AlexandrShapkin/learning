# Спринт 12. Устройства хранения и блочный ввод-вывод

Ориентировочный объём: 9–13 часов.

## Центральный вопрос

Как устройство хранения выполняет блочные операции и почему размер блока, очередь и access pattern меняют latency, IOPS и throughput?

## Результат спринта

После завершения необходимо уметь:

- различать block и character devices;
- объяснять sector, logical block, filesystem block и I/O request;
- сравнивать HDD и SSD по механизму доступа;
- различать latency, IOPS, bandwidth и queue depth;
- объяснять sequential и random I/O;
- объяснять роль kernel block layer, scheduler и device queue;
- интерпретировать базовый `fio` output и latency percentiles;
- объяснять buffered и direct I/O;
- отличать benchmark файла от benchmark raw device;
- проводить безопасный storage experiment без разрушения данных;
- объяснять влияние flush/FUA и volatile write cache на durability обзорно.

## Место в интенсиве

Предыдущий спринт довёл операцию до kernel/device boundary. Теперь рассматривается устройство и block layer. Эти знания понадобятся для корректного анализа storage performance и баз данных.

## Основной маршрут

### Шаг 1. Device model

Прочитать OSTEP:

- chapter 36 «I/O Devices» повторно;
- chapter 37 «Hard Disk Drives»;
- chapter 44 «Flash-based SSDs»;
- chapter 38 «RAID» обзорно, только latency/parallelism/failure trade-offs.

### Шаг 2. Linux block layer

Прочитать обзор:

- Block documentation: https://docs.kernel.org/block/index.html
- blk-mq: https://docs.kernel.org/block/blk-mq.html
- I/O priorities: https://docs.kernel.org/block/ioprio.html

Не требуется изучать kernel API. Нужно понять software/hardware queues и причины concurrency in storage.

### Шаг 3. fio

Изучить официальный manual:

- https://fio.readthedocs.io/en/latest/fio_doc.html

Обязательные параметры: `filename`, `size`, `rw`, `bs`, `iodepth`, `numjobs`, `direct`, `runtime`, `time_based`, `group_reporting`, `verify`, `output-format`.

## Ресурсы

### Обязательный маршрут

- OSTEP chapters 36, 37 и 44; chapter 38 обзорно.
- Linux blk-mq overview.
- fio official documentation.

### Альтернативные объяснения

- *Systems Performance*, chapters Disks and File Systems.
- Vendor architecture overviews для конкретного SSD/HDD, если они не подменяют общую модель маркетинговыми числами.
- `iostat` documentation.

### Углубление

- NVMe queues и command submission/completion;
- SSD FTL, write amplification, garbage collection и TRIM;
- RAID failure modes;
- zoned storage;
- persistent memory и DAX.

### Справочные материалы

- `lsblk(8)`, `blockdev(8)`, `iostat(1)`.
- `/sys/block/<device>/queue/` documentation.

## Правило безопасности

Все обязательные fio tests выполняются только над обычным test file в каталоге `work/storage-lab/data/` или на специально выделенном disposable volume.

Запрещено запускать destructive write workload на `/dev/sdX`, `/dev/nvmeXnY`, системном разделе или диске с ценными данными.

## Практические задания

### 1. Инвентаризация

Получить:

```bash
lsblk -o NAME,TYPE,SIZE,ROTA,LOG-SEC,PHY-SEC,MIN-IO,OPT-IO,MOUNTPOINTS
findmnt
cat /sys/block/<device>/queue/scheduler
cat /sys/block/<device>/queue/logical_block_size
cat /sys/block/<device>/queue/physical_block_size
cat /sys/block/<device>/queue/nr_requests
```

Определить, является ли underlying device физическим, virtual, loop, device-mapper или network-backed. В VM вывод описывает virtual device, а не обязательно host storage.

### 2. Units

Для workload 4 KiB random reads при 25k IOPS рассчитать:

- throughput в MiB/s;
- средний интервал между completions при queue depth 1;
- theoretical in-flight operations при average latency 2 ms по Little's Law.

Для 1 MiB sequential reads при 500 MiB/s рассчитать IOPS. Цель — не смешивать units.

### 3. fio job files

До запуска написать четыре job files:

- sequential read, 1 MiB, QD1;
- sequential write, 1 MiB, QD1;
- random read, 4 KiB, QD1;
- random read, 4 KiB, QD32.

Все используют отдельный 2–8 GiB test file в зависимости от свободного места, `runtime=30`, `time_based=1`, `group_reporting=1`. Для write включить `verify`, если размер и время позволяют.

## Лабораторная работа

Создать `work/storage-lab/`:

```text
jobs/
results/raw/
results/summary.csv
run.sh
README.md
```

`README.md` нужен только для указания tested device/filesystem, exact commands и существенных conclusions.

### Matrix workloads

Проверить combinations:

- `rw`: read, write, randread, randwrite, randrw;
- `bs`: 4 KiB, 64 KiB, 1 MiB;
- `iodepth`: 1, 4, 32;
- `numjobs`: 1 и 4;
- `direct`: 0 и 1, если filesystem/device поддерживает direct I/O.

Не требуется полный cartesian product. Обязательный набор должен изолировать по одному изменению: access pattern, block size, queue depth, parallel jobs и buffering.

### Требования к run script

- проверять свободное место;
- работать только внутри явно указанного directory;
- требовать подтверждение перед write tests;
- сохранять fio JSON output;
- записывать fio version, kernel, filesystem, mount options и device topology;
- не использовать root без необходимости;
- удалять test files только по отдельной `clean` command.

### Анализ

Для каждого run сохранить:

- IOPS;
- bandwidth;
- average latency;
- p50, p95, p99 и p99.9 latency;
- CPU usage;
- achieved queue depth;
- errors и short I/O.

Ответить:

1. Как block size меняет IOPS и bandwidth?
2. Как queue depth влияет на throughput и tail latency?
3. Чем random pattern отличается от sequential?
4. Что изменил `direct=1`?
5. Когда четыре jobs помогли, а когда создали contention?
6. Какие результаты описывают page cache, virtual disk или host cache, а не physical device?

## Дополнительный эксперимент

Сравнить buffered writes:

- без `fsync`;
- `fsync` в конце;
- `fsync` после каждого небольшого record;
- batching по 100 records.

Измерить latency distribution и объяснить difference между accepted by kernel, flushed to device и durable under power-loss assumptions.

Для SSD дополнительно можно выполнить read-only test после different access patterns и исследовать discard/TRIM только на disposable volume.

## Самопроверка

1. Почему 4 KiB random и 1 MiB sequential workload нельзя сравнить одной цифрой MB/s?
2. Как HDD seek/rotation влияют на random access?
3. Почему SSD всё равно имеет nonuniform latency?
4. Что делает queue depth?
5. Чем filesystem block отличается от hardware sector?
6. Что измеряет `direct=0` на warm cache?
7. Почему p99 важнее average для latency-sensitive workload?
8. Как virtualization скрывает реальное устройство?
9. Почему successful write не полностью определяет durability?

Практическая проверка: по двум fio JSON outputs определить, какой workload random/sequential и QD1/QD32, обосновав IOPS, bandwidth и latency distribution.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Блочные и символьные устройства** — interface и access model.
- **HDD и SSD** — механизмы, latency и ограничения.
- **Блочный ввод-вывод Linux** — requests, queues, scheduler и driver boundary.
- **IOPS, throughput и latency** — units и связь с workload.
- **Queue depth** — concurrency, throughput и tail latency.
- **Buffered и direct I/O** — page cache и alignment constraints.
- **Durability записи** — buffers, flush, device cache и failure assumptions.

## Когда переходить дальше

Можно переходить, когда fio suite безопасна и воспроизводима, results сохраняются в JSON, units не смешиваются, а выводы явно отделяют filesystem/page cache/virtualization/device effects.