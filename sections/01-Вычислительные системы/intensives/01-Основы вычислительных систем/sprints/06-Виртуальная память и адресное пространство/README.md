# Спринт 06. Виртуальная память и адресное пространство

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Как процесс получает собственное адресное пространство и как виртуальный адрес превращается в доступ к физической памяти или файлу?

## Результат спринта

После завершения необходимо уметь:

- различать виртуальные и физические адреса;
- объяснять pages, page tables, page faults и TLB;
- различать reservation, commitment и фактическое resident memory;
- находить code, data, heap, stack, shared libraries и mappings процесса;
- объяснять anonymous и file-backed mappings;
- объяснять demand paging и copy-on-write;
- различать `MAP_PRIVATE` и `MAP_SHARED`;
- объяснять stack growth и heap allocation без мифа «всё локальное всегда на stack»;
- интерпретировать `/proc/<pid>/maps`, `smaps` и page-fault counters;
- объяснять, почему virtual size не равен потреблению RAM.

## Место в интенсиве

Предыдущий спринт исследовал физическую иерархию памяти. Теперь добавляется механизм изоляции и отображения, который позволяет каждому процессу видеть собственное линейное пространство адресов.

## Основной маршрут

### Шаг 1. Адресное пространство

Прочитать OSTEP:

- глава 13 «The Abstraction: Address Spaces»;
- глава 14 «Interlude: Memory API»;
- глава 15 «Mechanism: Address Translation»;
- глава 18 «Paging: Introduction».

Сформировать модель: instruction использует virtual address, MMU и page tables выполняют translation, а TLB кеширует часть translations.

### Шаг 2. TLB и page tables

Прочитать OSTEP:

- глава 19 «Translation Lookaside Buffers»;
- глава 20 «Advanced Page Tables» обзорно;
- глава 21 «Beyond Physical Memory: Mechanisms»;
- глава 22 «Beyond Physical Memory: Policies» обзорно.

Не требуется запоминать конкретный page-replacement algorithm. Требуется понимать причины page fault и разницу между minor и major fault.

### Шаг 3. Programmer's perspective

Прочитать CS:APP 9.1–9.9. Сосредоточиться на:

- physical/virtual addressing;
- VM as caching, memory management and protection;
- address translation;
- Linux virtual memory organization;
- memory mapping;
- dynamic allocation.

### Шаг 4. Linux interfaces

Изучить:

- `mmap(2)`: https://man7.org/linux/man-pages/man2/mmap.2.html
- `mprotect(2)`: https://man7.org/linux/man-pages/man2/mprotect.2.html
- `madvise(2)`: https://man7.org/linux/man-pages/man2/madvise.2.html
- `proc_pid_maps(5)` и `proc_pid_smaps(5)` на man7.org.

## Ресурсы

### Обязательный маршрут

- OSTEP chapters 13–15, 18–22.
- CS:APP 3e, 9.1–9.9.
- `mmap(2)` и `/proc/<pid>/maps` documentation.

### Альтернативные объяснения

- UC Berkeley CS61C notes по virtual memory: https://notes.cs61c.org/
- Linux kernel Memory Management guide: https://docs.kernel.org/admin-guide/mm/index.html
- Tanenbaum, главы о memory management.

### Углубление

- multi-level page tables, huge pages и TLB reach;
- NUMA placement;
- transparent huge pages;
- allocator internals;
- Linux MM internals: https://docs.kernel.org/mm/index.html

### Справочные материалы

- `fork(2)`: https://man7.org/linux/man-pages/man2/fork.2.html
- `mincore(2)`, `mlock(2)`, `brk(2)`.
- `/proc` manual pages.

## Практические задания

### 1. Карта процесса

Для простого Go-приложения, которое ожидает input, получить:

```bash
cat /proc/$PID/maps
cat /proc/$PID/smaps_rollup
pmap -x $PID
```

Найти executable mappings, heap, stack, shared libraries, anonymous regions и permissions. Для каждой region объяснить `rwx`, private/shared и file backing.

### 2. Адреса объектов

Написать программу, выводящую addresses:

- global variable;
- local variable;
- heap-allocated object;
- function;
- memory-mapped file;
- goroutine local variable.

Сопоставить каждый address с region из `/proc/self/maps`. Не делать вывод, что все goroutine locals физически находятся в одном месте: compiler escape analysis и runtime stacks должны быть явно упомянуты.

### 3. Reserve и touch

Создать configurable anonymous mapping, по умолчанию 512 MiB. Последовательно измерить:

1. состояние сразу после `mmap`;
2. после чтения одного byte на page;
3. после записи одного byte на page;
4. после `madvise(..., MADV_DONTNEED)`.

На каждом этапе сохранить virtual size, RSS, PSS, minor/major faults. Размер должен уменьшаться parameter, если машине не хватает памяти.

## Лабораторная работа

Создать `work/vmprobe/` из Go CLI и небольшого C helper.

### Команды Go CLI

```text
vmprobe layout
vmprobe reserve --size 512MiB
vmprobe mmap --file data.bin --mode private
vmprobe mmap --file data.bin --mode shared
vmprobe faults --size 256MiB --pattern sequential
vmprobe faults --size 256MiB --pattern random
```

### C helper

`cow.c` должен:

1. выделить configurable buffer;
2. заполнить pages;
3. вызвать `fork()`;
4. вывести PID parent/child и RSS/PSS;
5. изменить половину pages в child;
6. снова вывести memory statistics;
7. дождаться child через `waitpid`.

### Требования

- безопасные значения размеров по умолчанию;
- явная проверка ошибок syscalls;
- parser `/proc/self/maps` покрыт tests;
- `MAP_SHARED`-изменение видно другому mapping или процессу;
- `MAP_PRIVATE`-изменение не изменяет исходный файл;
- page-fault experiment фиксирует raw counters и elapsed time;
- команды воспроизводятся через `make` или небольшой script.

### Проверка

```bash
go test ./...
perf stat -e page-faults,minor-faults,major-faults -- ./vmprobe faults --size 256MiB --pattern sequential
./cow 256
```

На системах, где отдельные perf events недоступны, использовать `/proc/self/stat` или `getrusage` и зафиксировать limitation.

## Дополнительный эксперимент

Сравнить доступ к 256 MiB mapping с обычными pages и huge pages, если система позволяет безопасно использовать `madvise(MADV_HUGEPAGE)`. Проверить `/proc/self/smaps` и не утверждать, что huge page была использована, пока это не подтверждено.

Дополнительный вариант: сравнить `MAP_POPULATE` и demand paging по startup time и faults.

## Самопроверка

1. Зачем процессу virtual memory, если RAM уже адресуемая?
2. Что именно кеширует TLB?
3. Чем page fault отличается от segmentation fault?
4. Почему новый большой mapping может почти не менять RSS?
5. Почему `fork()` обычно не копирует все pages немедленно?
6. Чем anonymous mapping отличается от file-backed mapping?
7. Как permissions page tables обеспечивают protection?
8. Чем heap, stack и mapping отличаются как abstractions и как regions?

Практическая проверка: по неизвестному `/proc/<pid>/maps` определить вероятные code, stack, heap, libraries и memory-mapped file, затем проверить через process behavior.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Виртуальная память** — цели: abstraction, isolation, caching и protection.
- **Адресное пространство процесса** — regions, permissions и mappings.
- **Страницы и таблицы страниц** — translation и page-table hierarchy.
- **TLB** — кеширование translations, misses и влияние на performance.
- **Page fault** — minor/major/protection fault и demand paging.
- **Copy-on-write** — sharing до записи и применение в `fork`/private mappings.
- **Stack и heap** — назначение, allocation и границы упрощённой модели.
- **Memory-mapped files** — private/shared mappings и связь с page cache.

## Когда переходить дальше

Можно переходить, когда каждый address лаборатории сопоставляется с mapping, reserve/touch/COW experiments объясняются через pages и faults, а VSZ/RSS/PSS больше не используются как взаимозаменяемые величины.