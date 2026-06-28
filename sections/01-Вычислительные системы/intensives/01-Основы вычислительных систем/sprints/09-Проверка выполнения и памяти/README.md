# Спринт 09. Проверка выполнения и памяти

Ориентировочный объём: 6–10 часов.

Новая теория не вводится. Первая попытка выполняется без повторного чтения спринтов 05–08.

## Проверяемые области

- cache locality;
- virtual memory и mappings;
- ELF, symbols и dynamic loading;
- processes, threads и execution context.

## Часть 1. Сквозная сборка

Создать проект `work/checkpoint-runner/`:

```text
include/plugin.h
plugin/plugin.c
app/main.c
Makefile
```

API:

```c
struct result {
    long sum;
    unsigned long touched_pages;
};

struct result run_workload(int *data, unsigned long count, int stride);
```

### Требования

- plugin собирается как shared library;
- application загружает его через `dlopen`/`dlsym`;
- application создаёт anonymous mapping через `mmap`;
- parent заполняет mapping;
- после `fork` child загружает plugin и выполняет workload;
- parent наблюдает child через `/proc` и `waitpid`;
- stride задаётся argument;
- размер mapping ограничен безопасным default 128 MiB.

## Часть 2. Предварительный прогноз

До запуска ответить:

1. Какие symbols будут undefined в application object?
2. Какие mappings появятся до и после `dlopen`?
3. Будет ли mapping parent и child физически разделяться до записи?
4. Что произойдёт с RSS/PSS после записи child?
5. Как stride повлияет на cache behavior?
6. Какие file descriptors наследует child?
7. Где будет stack parent и child?
8. Какие части process image заменились бы после `execve`?

Прогноз сохранить кратко в `work/checkpoint-runner/PREDICTION.md`.

## Часть 3. Наблюдение

Собрать:

```bash
readelf -h -S -l -d app/runner
readelf -r app/runner
nm -D plugin/libwork.so
LD_DEBUG=libs,bindings ./app/runner ...
strace -f -o trace.txt ./app/runner ...
perf stat -e cycles,instructions,cache-misses,page-faults,context-switches ./app/runner ...
```

Во время pause в parent/child сохранить:

- `/proc/$PID/maps`;
- `/proc/$PID/smaps_rollup`;
- `/proc/$PID/status`;
- `/proc/$PID/task/` listing.

## Часть 4. Диагностические сценарии

### Сценарий A. Missing library

Переместить shared library и запустить application. Диагностировать failure только через loader output, `readelf -d` и filesystem state. Затем исправить RUNPATH или controlled launch environment.

### Сценарий B. Неверная память

В child изменить весь mapping, хотя workload должен был только читать. Найти рост private dirty memory через `smaps` и доказать copy-on-write cause.

### Сценарий C. Плохая locality

Запустить stride 1 и stride 1024 на одинаковом объёме данных. Подтвердить difference timing и counters. Если hardware counters недоступны, использовать repeated timing и объяснить limitation.

### Сценарий D. Ошибка ожиданий о shared state

Parent ожидает, что обычная global variable, изменённая child, изменится и у parent. Воспроизвести failure и исправить design через shared mapping, pipe или другой явно выбранный IPC mechanism.

## Часть 5. Защита

Без материалов объяснить полный путь:

```text
source → object → shared object → executable → exec/loader
→ virtual mappings → fork/COW → instruction/data access
→ cache hierarchy → observed timing
```

Для каждого перехода указать используемый tool и одно наблюдаемое доказательство.

## Критерии прохождения

Checkpoint пройден, если:

- build воспроизводится одной командой;
- plugin действительно загружается динамически;
- mappings и loader output сопоставлены;
- COW подтверждён измерением, а не только словами;
- stride experiment использует одинаковый объём полезной работы;
- все четыре failures диагностированы доказательно;
- итоговое объяснение различает physical memory, virtual mapping, ELF section и process resource.

При затруднении:

- locality и cache counters → спринт 05;
- pages, RSS/PSS и COW → спринт 06;
- ELF/loader/symbols → спринт 07;
- fork, threads и inherited resources → спринт 08.

## Результат для базы знаний

Новые заметки не обязательны. Обновить существующие заметки только по тем механизмам, где прогноз разошёлся с наблюдением. Конкретные dumps и measurements остаются в `work/checkpoint-runner/`.