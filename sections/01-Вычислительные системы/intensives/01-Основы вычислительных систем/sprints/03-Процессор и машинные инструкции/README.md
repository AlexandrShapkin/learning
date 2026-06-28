# Спринт 03. Процессор и машинные инструкции

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Как исходные операции программы превращаются в машинные инструкции и изменения регистров, памяти и program counter?

## Результат спринта

После завершения необходимо уметь:

- различать ISA и микроархитектуру;
- объяснять основные классы инструкций: data movement, arithmetic, control flow и memory access;
- читать небольшой фрагмент x86-64 assembly;
- объяснять регистры общего назначения, instruction pointer и flags;
- связывать stack frame с вызовом функции;
- объяснять calling convention и ABI;
- использовать compiler, disassembler и debugger для проверки модели;
- сравнивать код `-O0` и `-O2` без оценки по длине alone;
- объяснять fetch-decode-execute и роль pipeline на концептуальном уровне.

## Место в интенсиве

Логические схемы предыдущего спринта становятся процессором, когда ISA задаёт видимое программам поведение. Этот спринт создаёт основу для linking, processes, virtual memory и performance.

## Основной маршрут

### Шаг 1. ISA и RISC-V как учебная модель

Изучить Berkeley CS61C notes по RISC-V introduction, registers, instruction formats, calling convention и control flow: https://notes.cs61c.org/

В RISC-V specification прочитать только обзор base integer ISA и register state: https://docs.riscv.org/reference/isa/unpriv/

Цель — понять компактную load/store ISA, а не запомнить все opcodes.

### Шаг 2. Реальный x86-64-код

Прочитать CS:APP, глава 3:

- 3.1 Historical Perspective;
- 3.2 Program Encodings;
- 3.3 Data Formats;
- 3.4 Accessing Information;
- 3.5 Arithmetic and Logical Operations;
- 3.6 Control;
- 3.7 Procedures;
- 3.10.3–3.10.4 про memory access и stack дисциплину.

### Шаг 3. Debugger и disassembler

Освоить только необходимые команды:

```text
objdump -d -Mintel
readelf -h -S
nm
size
gdb: break, run, disassemble, info registers, x, si, ni, bt
```

### Шаг 4. Pipeline и execution

Прочитать CS:APP 4.1–4.4 обзорно. Требуется объяснять pipeline hazards, branch prediction и почему ISA не раскрывает конкретное устройство исполнения. Реализация Y86 processor необязательна.

## Ресурсы

### Обязательный маршрут

- CS:APP 3e, глава 3 и обзор 4.1–4.4.
- CS61C notes по RISC-V и calling convention.
- System V AMD64 ABI, разделы registers и calling sequence: https://gitlab.com/x86-psABIs/x86-64-ABI

### Альтернативные объяснения

- Nand2Tetris, Project 4 Machine Language: https://www.nand2tetris.org/project04
- Compiler Explorer для визуального сравнения: https://godbolt.org/
- Patterson & Hennessy, главы Instruction Set и Processor.

### Углубление

- Intel SDM Volume 1, главы Basic Architecture и Instruction Execution.
- Intel SDM Volume 2 как справочник инструкций.
- CS:APP Architecture Lab или Nand2Tetris CPU project.

### Справочные материалы

- `man objdump`, `man readelf`, `man gdb`.
- `go tool compile -S` и `go tool objdump`: https://pkg.go.dev/cmd/objdump

## Практические задания

Использовать следующий файл `work/machine/main.c`:

```c
#include <stdint.h>
#include <stdio.h>

static int clamp(int x, int low, int high) {
    if (x < low) return low;
    if (x > high) return high;
    return x;
}

static int64_t dot(const int32_t *a, const int32_t *b, int n) {
    int64_t sum = 0;
    for (int i = 0; i < n; i++) {
        sum += (int64_t)a[i] * b[i];
    }
    return sum;
}

int main(void) {
    int32_t a[] = {1, -2, 3, 4};
    int32_t b[] = {5, 6, -7, 8};
    int x = clamp((int)dot(a, b, 4), -20, 20);
    printf("%d\n", x);
    return 0;
}
```

### 1. Компиляция

Собрать варианты:

```bash
cc -O0 -g -fno-omit-frame-pointer -o app-O0 main.c
cc -O2 -g -fno-omit-frame-pointer -o app-O2 main.c
cc -O2 -S -masm=intel -o app.s main.c
```

До дизассемблирования предсказать final output и количество итераций loop.

### 2. Статический анализ

Для `app-O0` и `app-O2` определить:

- entry point;
- symbols `main`, `clamp`, `dot`, если они существуют;
- инструкции, реализующие сравнения;
- условные и безусловные переходы;
- регистры аргументов первых функций;
- место хранения `sum`;
- изменение stack pointer;
- наличие или отсутствие отдельных вызовов `clamp` и `dot` после оптимизации.

Все утверждения подтвердить конкретным адресом или фрагментом disassembly.

### 3. Динамическая трассировка

В GDB:

1. остановиться в `main`;
2. перейти в `dot`;
3. показать argument registers;
4. выполнить одну итерацию instruction-by-instruction;
5. показать память массивов через `x`;
6. получить backtrace;
7. вернуться в caller и показать return value.

Сохранить команды в `work/machine/gdb.txt`; полный transcript не требуется.

### 4. Calling convention

Нарисовать stack и registers в момент входа в `dot`. Указать return address, stack pointer, frame pointer, arguments и caller/callee-saved registers, которые реально встречаются в бинарном файле.

## Лабораторная работа

Создать `work/machine/analyze.sh`, который принимает путь к ELF binary и формирует каталог:

```text
analysis/
├── file.txt
├── elf-header.txt
├── sections.txt
├── symbols.txt
├── disassembly.txt
└── sizes.txt
```

### Требования

- использовать `file`, `readelf`, `nm`, `objdump`, `size`;
- завершаться ошибкой для несуществующего или не-ELF файла;
- не требовать root;
- сохранять точную команду и версию compiler в `build.txt`;
- работать для обоих вариантов `app-O0` и `app-O2`;
- иметь небольшой shell test, проверяющий наличие outputs и symbols.

После выполнения написать в `analysis/README.md` только пять содержательных выводов: какие функции были inline, где находится loop, как передаются arguments, чем отличаются sections и какие оптимизации видны. Не пересказывать весь вывод tools.

## Дополнительный эксперимент

Написать эквивалент функции `dot` на Go и получить assembly:

```bash
go test -c -o dot.test .
go tool objdump -s '.*Dot' dot.test
```

Сравнить:

- calling convention;
- bounds checks;
- stack growth checks;
- использование vector instructions, если есть;
- влияние `//go:noinline`.

Цель — увидеть роль runtime и compiler, а не объявить один язык «быстрее».

## Самопроверка

1. Чем ISA отличается от assembly syntax и микроархитектуры?
2. Почему одна строка C может соответствовать нулю, одной или многим инструкциям?
3. Где хранится return address?
4. Зачем ABI делит registers на caller-saved и callee-saved?
5. Почему branch prediction не является частью результата программы?
6. Почему `-O2`-код нельзя понимать как построчный перевод source?

Практическая проверка: выбрать одну функцию, скрыть source и восстановить её назначение только по disassembly, аргументам и тестовым вызовам.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **ISA** — контракт между software и processor; связать с микроархитектурой и compiler.
- **Машинные инструкции** — encoding, operands и основные классы операций.
- **Регистры процессора** — general purpose, stack pointer, instruction pointer и flags.
- **Вызов функции и ABI** — arguments, return value, stack frame и сохранение registers.
- **Цикл выполнения инструкции** — fetch, decode, execute, memory, write-back; не привязывать к одной pipeline реализации.
- **Конвейер процессора** — throughput, hazards и branch prediction на обзорном уровне.

## Когда переходить дальше

Можно переходить, когда обе сборки исследованы, debugger trace воспроизводится, аргументы и return value находятся без подсказки, а различия ISA/ABI/microarchitecture объясняются на конкретном примере.