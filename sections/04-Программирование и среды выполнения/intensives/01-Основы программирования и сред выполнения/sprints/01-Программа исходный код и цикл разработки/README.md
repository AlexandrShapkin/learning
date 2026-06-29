# Спринт 01. Программа, исходный код и цикл разработки

Ориентировочный объём: 9–13 часов.

## Центральный вопрос

Что именно создаёт программист, какие преобразования проходит исходный код и как построить короткий воспроизводимый цикл «изменение → проверка → запуск»?

## Результат спринта

После завершения необходимо уметь:

- различать source code, source file, package, module, library, executable и process;
- объяснять роль editor, compiler, linker, runtime, OS loader и shell на обзорном уровне;
- использовать `go run`, `go build`, `go test`, `go fmt`, `go vet` по назначению;
- читать compiler diagnostics и не устранять их механическим копированием;
- организовать минимальный Go module с `cmd/`, `internal/` и tests без преждевременной архитектуры;
- различать build-time, startup-time и runtime failures;
- определять observable behavior через input, output, exit code, files и side effects;
- писать deterministic command-line program;
- использовать Git commits как сохранение работающих состояний;
- формулировать acceptance examples до реализации;
- отделять specification от implementation detail;
- воспроизводить сборку и тесты одной командой.

## Место в интенсиве

Спринт задаёт рабочий процесс всего курса. Следующие темы добавляют языковые и runtime-механизмы, но artifacts, tests и commands остаются основным доказательством результата.

## Основной маршрут

### Шаг 1. Что такое программа

Изучить:

- Go Tour: packages, functions, basic program structure;
- `go help build`, `go help run`, `go help test`;
- обзор process model из предыдущего интенсива ОС.

Разобрать цепочку:

```text
requirements → source files → parser/type checker/compiler/linker
→ executable → OS loader → process → observable behavior
```

На этом этапе детали compiler pipeline не требуются; они появятся в спринте 08.

### Шаг 2. Go module и package

Изучить:

- `go mod init`;
- package declarations and imports;
- exported/unexported identifiers;
- `main` package and `main` function;
- tests in `_test.go` files.

### Шаг 3. Development loop

Собрать минимальный workflow:

```bash
gofmt -w .
go test ./...
go vet ./...
go build ./cmd/...
```

Добавить Makefile только как thin wrapper над понятными commands.

### Шаг 4. Specification через examples

Для каждого behavior записывать:

```text
Input
Expected output
Expected exit code
Expected side effects
Invalid input behavior
```

Не писать отдельные status tables.

## Ресурсы

### Обязательный маршрут

- A Tour of Go: Basics and Packages.
- Go command documentation: build, run, test, fmt, vet.
- Effective Go: introduction, formatting, package names.
- Git basics: status, diff, add, commit.

### Альтернативные объяснения

- *The Go Programming Language*, chapters 1–2.
- CS:APP overview of program translation and execution.

### Углубление

- hermetic builds;
- build IDs;
- source control workflows;
- editor/LSP protocol;
- build systems beyond Go toolchain.

## Практические задания

### 1. Hello as evidence

Создать module и программу, которая:

- принимает имя через flag;
- печатает greeting строго в stdout;
- ошибки печатает в stderr;
- возвращает non-zero exit code при invalid input;
- имеет tests для pure formatting function;
- собирается в отдельный `bin/` только локально, binary не коммитится.

### 2. Failure classification

Создать и затем исправить по одному примеру:

- syntax error;
- type error;
- missing import/dependency;
- link/build error where practical;
- startup failure due missing file;
- runtime error due invalid data;
- incorrect output with successful exit.

Для каждого сохранить одну строку classification и reproduction command.

### 3. Determinism

Показать, почему current time, random seed, map iteration или environment can make output unstable. Перепроектировать code так, чтобы clock/random/environment передавались явно или нормализовались в tests.

### 4. Repository hygiene

Подготовить `.gitignore` для binaries, profiles, editor files и temporary outputs. Проверить `git status` after build/test.

## Лабораторная работа

Создать `work/wordstat/` — CLI, считающий строки, слова, bytes и Unicode code points.

### Interface

```text
wordstat [--json] [--mode lines|words|bytes|runes|all] [FILE|-]
```

### Требования

- stdin при `-` или отсутствии file;
- stdout содержит только result;
- stderr содержит diagnostics;
- exit codes различают usage error и input/read error;
- JSON output deterministic;
- library package не зависит от CLI flags;
- tests: empty input, ASCII, Unicode, long line, invalid file;
- golden fixtures малы и понятны;
- build/test/check through Makefile;
- README содержит examples, не дневник разработки.

### Failure scenarios

1. Missing file.
2. Permission denied.
3. Broken pipe on output where reproducible.
4. Scanner/token limit on huge word/line.
5. Invalid flag combination.
6. Unicode counted as bytes incorrectly.

### Definition of done

```bash
gofmt -w .
go test ./...
go vet ./...
go build ./cmd/wordstat
```

Все команды проходят, CLI behavior совпадает с examples, cleanup не оставляет binary в Git.

## Дополнительный эксперимент

Собрать программу с `go build -x -work` и посмотреть high-level tool commands/temp directory. Не разбирать compiler internals преждевременно; зафиксировать только наблюдаемую последовательность.

## Самопроверка

1. Чем source file отличается от executable?
2. Что делает `go run` по сравнению с `go build`?
3. Что такое package и module?
4. Где начинается observable behavior программы?
5. Чем compile-time failure отличается от runtime failure?
6. Почему stdout и stderr нужно разделять?
7. Почему exit code является частью интерфейса CLI?
8. Что делает build reproducible?
9. Зачем pure logic отделять от `main`?
10. Почему passing tests не доказывают все requirements?

Практическая проверка: клонировать проект в чистый каталог и выполнить build/test/run только по README.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Программа и процесс** — source, executable and running instance.
- **Цикл разработки** — edit, format, test, build and run.
- **Go package and module** — compilation and dependency units.
- **Observable behavior программы** — input, output, exit code and side effects.
- **Build-time, startup-time and runtime errors**.
- **Deterministic program behavior**.

## Когда переходить дальше

Можно переходить, когда `wordstat` воспроизводимо собирается из clean checkout, errors correctly use stderr/exit codes, and development loop runs through one documented command.