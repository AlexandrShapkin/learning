# Спринт 07. Сборка, связывание и загрузка программ

Ориентировочный объём: 9–13 часов.

## Центральный вопрос

Как исходные файлы, библиотеки и символы превращаются в исполняемый ELF-файл, а затем в mappings работающего процесса?

## Результат спринта

После завершения необходимо уметь:

- различать preprocessing, compilation, assembly, linking и loading;
- объяснять object file, executable и shared object;
- читать основные ELF headers, sections и program headers;
- различать symbol definition, undefined symbol и relocation;
- объяснять static и dynamic linking;
- объяснять GOT, PLT и position-independent code на обзорном уровне;
- находить зависимости через `readelf`, `nm`, `objdump` и `ldd`;
- объяснять роль dynamic loader и search path;
- связывать ELF segments с `/proc/<pid>/maps`;
- диагностировать missing symbol, missing library и ABI mismatch.

## Место в интенсиве

Спринт 03 показал machine code, а спринт 06 — address space. Теперь они связываются: linker организует code/data, loader создаёт mappings, выполняет relocations и передаёт управление entry point.

## Основной маршрут

### Шаг 1. От source до object file

Прочитать CS:APP chapter 7:

- 7.1 Compiler Drivers;
- 7.2 Static Linking;
- 7.3 Object Files;
- 7.4 Relocatable Object Files;
- 7.5 Symbols and Symbol Tables;
- 7.6 Symbol Resolution;
- 7.7 Relocation.

### Шаг 2. Executable и process image

Прочитать:

- CS:APP 7.8–7.10;
- CS:APP 7.12 Position-Independent Code;
- `execve(2)`: https://man7.org/linux/man-pages/man2/execve.2.html
- `ld.so(8)`: https://man7.org/linux/man-pages/man8/ld.so.8.html

### Шаг 3. GNU toolchain

Использовать документацию:

- GNU `ld`: https://sourceware.org/binutils/docs/ld/
- GNU Binutils: https://sourceware.org/binutils/docs/

Не требуется изучать linker scripts целиком. Нужны entry point, sections, symbols, relocations, dynamic dependencies и library search.

## Ресурсы

### Обязательный маршрут

- CS:APP 3e, глава 7.
- `execve(2)`, `ld.so(8)`.
- `readelf`, `nm`, `objdump`, `ar`, `ldd` manual pages.

### Альтернативные объяснения

- Eli Bendersky, серии об ELF, linking и loading: https://eli.thegreenplace.net/tag/linkers-and-loaders
- Ian Lance Taylor, «Linkers» series: https://www.airs.com/blog/archives/38
- Linux Foundation ELF references: https://refspecs.linuxfoundation.org/

### Углубление

- System V ABI и AMD64 ABI.
- lazy binding, symbol interposition и versioned symbols;
- linker scripts;
- static PIE и fully static Go binaries;
- dynamic loader source in glibc.

### Справочные материалы

- GNU `ld` manual.
- `dlopen(3)`, `dlsym(3)`, `dladdr(3)`.
- `file(1)`, `strip(1)`, `size(1)`.

## Практические задания

Использовать структуру:

```text
work/elflab/
├── include/calc.h
├── lib/calc.c
├── app/main.c
└── Makefile
```

API библиотеки:

```c
long calc_sum(const int *values, unsigned long count);
const char *calc_version(void);
```

### 1. Этапы compiler driver

Получить и сохранить:

```bash
cc -E app/main.c -Iinclude -o main.i
cc -S app/main.c -Iinclude -o main.s
cc -c app/main.c -Iinclude -o main.o
```

Для каждого файла объяснить, какая информация появилась или исчезла.

### 2. Static library

Создать `libcalc.a` через `ar`, собрать statically linked-to-archive application и проверить:

- где определён `calc_sum` до linking;
- что происходит с undefined symbol в `main.o`;
- какие symbols попали в executable;
- почему archive member извлекается только при необходимости.

Полностью статический glibc binary не требуется.

### 3. Shared library

Собрать:

```bash
cc -fPIC -c lib/calc.c -Iinclude -o calc.pic.o
cc -shared -Wl,-soname,libcalc.so.1 -o libcalc.so.1.0 calc.pic.o
```

Создать symlinks `libcalc.so.1` и `libcalc.so`, затем linked application с безопасным relative RUNPATH `$ORIGIN/lib` либо запуском через `LD_LIBRARY_PATH` только внутри лаборатории.

### 4. ELF analysis

Для object, shared library и executable сравнить:

- ELF type;
- sections;
- program headers;
- symbol tables;
- relocations;
- `NEEDED`, `SONAME`, `RUNPATH`;
- entry point;
- file size и mapped segments.

## Лабораторная работа

Создать воспроизводимый `Makefile` с targets:

```text
preprocess
assembly
objects
static
shared
inspect
run-static
run-shared
clean
```

### Эксперимент 1. Dynamic loading

1. Запустить shared variant с `LD_DEBUG=libs,bindings`.
2. Найти загрузку `libcalc.so.1` и resolution `calc_sum`.
3. Сопоставить program headers с `/proc/$PID/maps`.
4. Объяснить, почему sections и mapped segments не совпадают один к одному.

### Эксперимент 2. Совместимое обновление

Заменить implementation `calc_sum`, не меняя signature/SONAME, пересобрать только shared library и убедиться, что application использует новое поведение без relink.

### Эксперимент 3. Несовместимое обновление

Переименовать symbol или изменить SONAME и воспроизвести loader error. Сохранить точную ошибку и диагностировать её через `readelf -d`, `nm -D` и loader search path.

### Тесты

- unit test библиотеки;
- integration test static variant;
- integration test shared variant;
- test, подтверждающий ожидаемую failure при missing library.

## Дополнительный эксперимент

Собрать executable как PIE и non-PIE:

```bash
cc -fPIE -pie ...
cc -no-pie ...
```

Запустить каждый несколько раз и сравнить addresses `main`, heap, stack и shared libraries. Связать результат с ASLR, не делая вывод, что PIE является полной защитой.

Дополнительно сравнить обычный Go binary и `go build -buildmode=pie` через `file`, `readelf` и `go tool nm`.

## Самопроверка

1. Почему compilation unit может содержать undefined symbols?
2. Чем section отличается от segment?
3. Когда выполняется relocation?
4. Зачем shared library нужен SONAME?
5. Как dynamic loader находит library?
6. Почему `ldd` нельзя бездумно запускать на недоверенном binary?
7. Как PIE связан с ASLR?
8. Что происходит между `execve` и вызовом `main`?

Практическая проверка: получить binary без source и определить, dynamically ли он linked, какие libraries нужны, какие symbols экспортирует и какие regions появятся в process maps.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Этапы сборки программы** — preprocessing, compilation, assembly и linking.
- **Object files и symbols** — definitions, references, symbol tables и relocations.
- **ELF** — headers, sections, segments и program loading.
- **Статическое и динамическое связывание** — trade-offs и момент resolution.
- **Динамический загрузчик** — dependencies, search path, relocation и transfer of control.
- **ABI** — binary contracts между compiler, libraries и runtime.
- **Position-independent code и PIE** — назначение и связь с ASLR.

## Когда переходить дальше

Можно переходить, когда static/shared builds воспроизводимы, loader failure диагностируется без угадывания, а любой основной ELF output связывается с конкретным этапом build/load.