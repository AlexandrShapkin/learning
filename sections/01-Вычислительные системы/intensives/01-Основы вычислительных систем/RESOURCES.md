# Ресурсы интенсива

Каталог содержит общую библиографию. Конкретный обязательный маршрут указан внутри каждого спринта; читать все источники целиком не требуется.

## Основные учебники и курсы

### Computer Systems: A Programmer's Perspective, 3rd Edition

Randal E. Bryant, David R. O'Hallaron. Основной связующий учебник интенсива: представление данных, машинный код, оптимизация, память, linking, exceptional control flow, virtual memory, I/O и concurrency.

- Официальный сайт: https://csapp.cs.cmu.edu/3e/home.html
- Описание подхода: https://csapp.cs.cmu.edu/3e/perspective.html
- Официальные лаборатории: https://csapp.cs.cmu.edu/3e/labs.html

Книга коммерческая. В интенсиве всегда указаны точные главы; официальный сайт используется для дополнительных материалов и лабораторий.

### Operating Systems: Three Easy Pieces

Remzi H. Arpaci-Dusseau, Andrea C. Arpaci-Dusseau. Бесплатный основной источник по процессам, виртуальной памяти, конкурентности и устройствам.

- Книга и главы: https://pages.cs.wisc.edu/~remzi/OSTEP/
- Код: https://pages.cs.wisc.edu/~remzi/OSTEP/Code/

### Nand2Tetris

Практический маршрут от логических элементов до компьютера, машинного языка и software stack.

- Курс и проекты: https://www.nand2tetris.org/course
- Инструменты: https://www.nand2tetris.org/software

Для основного интенсива используются отдельные проекты 1–3 и 4. Полное прохождение курса остаётся самостоятельным углублением.

### UC Berkeley CS 61C

Курс Great Ideas in Computer Architecture. Используется как альтернативное объяснение представления данных, RISC-V, caches, virtual memory, parallelism и performance.

- Актуальный сайт курса: https://cs61c.org/
- Конспекты: https://notes.cs61c.org/

### Дополнительные книги

- David A. Patterson, John L. Hennessy, *Computer Organization and Design RISC-V Edition* — углубление в ISA и устройство процессора.
- Andrew S. Tanenbaum, Todd Austin, *Structured Computer Organization* — альтернативный обзор уровней вычислительной системы.
- Jon Stokes, *Inside the Machine* — визуальное объяснение процессоров и микроархитектуры.

## Спецификации процессора

### RISC-V

Открытая ISA удобна для изучения формата инструкций и связи ISA с микроархитектурой.

- Библиотека ратифицированных спецификаций: https://docs.riscv.org/reference/home/index.html
- Unprivileged ISA: https://docs.riscv.org/reference/isa/unpriv/
- Privileged architecture: https://docs.riscv.org/reference/isa/priv/

### x86-64

Используется для исследования реальных бинарных файлов на обычной Linux-машине.

- Intel Software Developer Manuals: https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html

Руководства не читаются последовательно. Нужные таблицы и разделы используются как справочник.

## Linux и системные интерфейсы

- Linux man-pages: https://man7.org/linux/man-pages/
- Документация ядра: https://docs.kernel.org/
- Memory management: https://docs.kernel.org/admin-guide/mm/index.html
- Внутренняя документация MM: https://docs.kernel.org/mm/index.html
- Block layer: https://docs.kernel.org/block/index.html
- Virtualization/KVM: https://docs.kernel.org/virt/kvm/index.html
- cgroup v2: https://docs.kernel.org/admin-guide/cgroup-v2.html
- namespaces overview: https://man7.org/linux/man-pages/man7/namespaces.7.html

## Форматы файлов и toolchain

- GNU linker `ld`: https://sourceware.org/binutils/docs/ld/
- GNU Binutils: https://sourceware.org/binutils/docs/
- System V AMD64 ABI: https://gitlab.com/x86-psABIs/x86-64-ABI
- ELF specification и ABI supplements доступны через https://refspecs.linuxfoundation.org/

## Go

- Официальная документация: https://go.dev/doc/
- Спецификация: https://go.dev/ref/spec
- Memory model: https://go.dev/ref/mem
- `runtime/pprof`: https://pkg.go.dev/runtime/pprof
- `net/http/pprof`: https://pkg.go.dev/net/http/pprof
- Go execution tracer: https://go.dev/blog/execution-traces-2024

## Производительность

- `perf(1)`: https://man7.org/linux/man-pages/man1/perf.1.html
- `perf_event_open(2)`: https://man7.org/linux/man-pages/man2/perf_event_open.2.html
- Linux workload tracing: https://docs.kernel.org/admin-guide/workload-tracing.html
- Go profiling: https://go.dev/blog/pprof
- Brendan Gregg, *Systems Performance, 2nd Edition* — дополнительная книга по системной методологии и инструментам.
- Agner Fog optimization manuals: https://www.agner.org/optimize/

## Хранение и ввод-вывод

- OSTEP persistence chapters: https://pages.cs.wisc.edu/~remzi/OSTEP/
- Linux multi-queue block layer: https://docs.kernel.org/block/blk-mq.html
- fio documentation: https://fio.readthedocs.io/en/latest/fio_doc.html
- fio source: https://github.com/axboe/fio

## Виртуализация и изоляция

- QEMU documentation: https://www.qemu.org/docs/master/
- QEMU system emulation introduction: https://www.qemu.org/docs/master/system/introduction.html
- KVM API: https://docs.kernel.org/virt/kvm/index.html
- Linux namespaces: https://man7.org/linux/man-pages/man7/namespaces.7.html
- cgroup v2: https://docs.kernel.org/admin-guide/cgroup-v2.html

## Как использовать каталог

1. Начинать с обязательного маршрута конкретного спринта.
2. Использовать альтернативное объяснение только при затруднении или для проверки модели.
3. Читать спецификации точечно по указанным разделам.
4. Углублённые материалы не должны задерживать переход к практике.
5. Не сохранять копии книг и курсов в репозитории.