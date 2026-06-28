# Спринт 11. Системные вызовы, прерывания и ввод-вывод

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Как пользовательская программа передаёт работу ядру и что происходит между вызовом `read` и появлением данных в памяти процесса?

## Результат спринта

После завершения необходимо уметь:

- различать function call, system call, exception, fault, trap и hardware interrupt;
- объяснять переход user mode → kernel mode → user mode;
- объяснять file descriptor и open file description;
- прослеживать `open/read/write/close` через `strace`;
- различать buffering в application, standard library, kernel page cache и устройстве;
- объяснять blocking, nonblocking и asynchronous I/O на обзорном уровне;
- объяснять partial read/write и обработку `EINTR`;
- связывать system-call count, buffer size, latency и throughput;
- объяснять роль DMA и interrupts без детального устройства driver;
- отличать данные, уже находящиеся в page cache, от чтения с физического устройства.

## Место в интенсиве

Процессы и потоки выполняют инструкции в user mode, но доступ к файлам, памяти и устройствам требует контролируемого перехода в kernel. Этот спринт связывает exceptional control flow, file descriptors, memory mappings и устройства.

## Основной маршрут

### Шаг 1. Exceptional control flow

Прочитать CS:APP:

- 8.1 Exceptions;
- 8.2 Processes — повторить только связь с control flow;
- 8.5 Signals обзорно.

Составить таблицу: synchronous/asynchronous, software/hardware source, expected return point для syscall, page fault, divide-by-zero и device interrupt.

### Шаг 2. System-level I/O

Прочитать CS:APP chapter 10 целиком. Сосредоточиться на Unix I/O model, file descriptors, metadata, robust reading/writing и buffering.

### Шаг 3. Устройства и interrupts

Прочитать OSTEP chapter 36 «I/O Devices». Понять memory-mapped I/O, programmed I/O, DMA, polling, interrupt-driven I/O и device driver abstraction.

### Шаг 4. Linux interfaces

Изучить:

- `open(2)`: https://man7.org/linux/man-pages/man2/open.2.html
- `read(2)`: https://man7.org/linux/man-pages/man2/read.2.html
- `write(2)`: https://man7.org/linux/man-pages/man2/write.2.html
- `lseek(2)`, `dup(2)`, `fcntl(2)`, `fsync(2)`;
- `strace(1)`.

`io_uring` читается только обзорно: https://man7.org/linux/man-pages/man7/io_uring.7.html

## Ресурсы

### Обязательный маршрут

- CS:APP 8.1 и chapter 10.
- OSTEP chapter 36.
- Linux man pages `open/read/write/close/dup/fsync`.

### Альтернативные объяснения

- *The Linux Programming Interface*, chapters File I/O и File I/O Buffering.
- Linux Device Drivers, introductory chapters — только концепции driver/interrupt/DMA.
- Julia Evans, материалы о strace и syscalls как визуальное дополнение.

### Углубление

- `epoll`, readiness и event-driven I/O;
- POSIX AIO и `io_uring`;
- zero-copy: `sendfile`, `splice`;
- direct I/O;
- interrupt coalescing и polling in high-performance devices.

### Справочные материалы

- `syscalls(2)`, `signal(7)`, `epoll(7)`.
- `proc_interrupts(5)` и `/proc/interrupts`.

## Практические задания

### 1. Function call и syscall

Написать минимальную C-программу, которая выводит строку двумя способами:

1. `printf`;
2. прямой `write(STDOUT_FILENO, ...)`.

Сравнить disassembly и `strace`. Объяснить, почему наличие call instruction не доказывает syscall и почему `printf` может выполнить один, несколько или ноль `write` до flush.

### 2. File descriptors

Написать программу:

1. открыть файл;
2. дублировать descriptor через `dup`;
3. прочитать bytes через первый descriptor;
4. прочитать через второй;
5. выполнить `fork` и продолжить чтение parent/child.

До запуска предсказать offsets. После запуска объяснить shared open file description и отличить его от двух независимых `open`.

### 3. Partial I/O

Реализовать `read_full` и `write_full`, которые корректно обрабатывают partial result и `EINTR`. Проверить через pipe с small writes и signal interruption. Нельзя считать, что один `read` возвращает requested length.

### 4. Buffering layers

Для программы, печатающей 1000 коротких строк, сравнить:

- `printf` в terminal;
- `printf` с redirect в файл;
- `fflush` после каждой строки;
- direct `write` каждой строки;
- один aggregated `write`.

Сравнить syscall count через `strace -c`.

## Лабораторная работа

Создать `work/iolab/` с Go-программой `filecopy`.

### Реализации

```text
filecopy byte       # чтение по 1 byte
filecopy buffer     # configurable buffer
filecopy bufio      # bufio.Reader/Writer
filecopy copy       # io.Copy
filecopy mmap       # mmap helper допустим на C или golang.org/x/sys/unix
```

### Требования

- source и destination задаются arguments;
- correctness проверяется SHA-256;
- поддерживаются buffer sizes 1, 4 KiB, 64 KiB и 1 MiB;
- ошибки и partial writes обрабатываются явно;
- test file создаётся deterministic generator, default 256 MiB с возможностью уменьшения;
- каждый run выполняется минимум 5 раз;
- raw times и syscall summary сохраняются;
- для write-path есть configurable `fsync`: never/end/frequently;
- программа не удаляет чужие файлы и работает только с указанным output.

### Измерения

```bash
strace -c ./filecopy buffer --size 4096 source.bin dest.bin
perf stat -e task-clock,context-switches,page-faults ./filecopy ...
```

Отдельно измерить cold/warm distinction настолько, насколько позволяет окружение. Не использовать `echo 3 > /proc/sys/vm/drop_caches` как обязательный шаг: это требует root и влияет на всю систему. Предпочтительны новый файл, working set больше available cache или direct I/O в дополнительном эксперименте.

### Ожидаемый анализ

Объяснить:

- связь buffer size и syscall count;
- почему меньше syscalls не гарантирует пропорциональное ускорение;
- какие runs вероятно обслужены page cache;
- влияние `fsync` на latency и durability semantics;
- почему `mmap` не означает отсутствие I/O или page faults.

## Дополнительный эксперимент

Создать pipe между producer и consumer. Сравнить blocking descriptor и `O_NONBLOCK` с `poll`/`epoll`. Producer пишет chunks с задержкой; consumer обязан корректно обрабатывать readiness, `EAGAIN`, EOF и partial reads.

Альтернатива для углубления: реализовать один вариант file copy через `io_uring` и сравнить не только speed, но complexity и количество context switches.

## Самопроверка

1. Чем syscall отличается от обычного call?
2. Что сохраняется при переходе в kernel mode?
3. Почему page fault считается exception, хотя часто не является ошибкой?
4. Что именно обозначает file descriptor?
5. Где может находиться buffer между application и storage device?
6. Почему `write` success не всегда означает durable data?
7. Как DMA уменьшает участие CPU?
8. Почему hardware interrupt асинхронен относительно instruction stream?
9. Когда nonblocking I/O полезен, а когда только усложняет код?

Практическая проверка: по `strace` неизвестной программы восстановить high-level I/O pattern, buffering behavior и места вероятного blocking.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Системные вызовы** — controlled transition, ABI и error model.
- **Исключения и прерывания** — synchronous/asynchronous control transfer.
- **File descriptors** — descriptor table, open file description и inheritance.
- **Буферизация ввода-вывода** — application, library, kernel и device layers.
- **Блокирующий и неблокирующий I/O** — semantics, readiness и trade-offs.
- **DMA** — передача данных между device и memory и роль interrupts.
- **Page cache** — связь file I/O, memory mappings и cached pages.

## Когда переходить дальше

Можно переходить, когда filecopy variants проверяются hash, syscall counts объяснимы, partial I/O обработан корректно, а путь `read` разделяется на user/library/kernel/device layers без смешения buffers.