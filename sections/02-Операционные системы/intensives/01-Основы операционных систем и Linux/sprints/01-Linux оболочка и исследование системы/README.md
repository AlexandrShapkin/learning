# Спринт 01. Linux, оболочка и исследование системы

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Как исследовать неизвестную Linux-систему, безопасно преобразовывать данные в shell и отличать состояние системы от текста, который выводит отдельная команда?

## Результат спринта

После завершения необходимо уметь:

- объяснять роль shell, terminal, command, process и environment;
- ориентироваться в Filesystem Hierarchy Standard на практическом уровне;
- использовать man pages, `info`, `--help` и package documentation;
- различать pathname, inode, file descriptor и stream на обзорном уровне;
- управлять quoting, expansions, variables, exit statuses и pipelines Bash;
- перенаправлять stdin/stdout/stderr без потери ошибок;
- безопасно использовать `find`, `xargs`, `grep`, `sed`, `awk`, `sort`, `uniq`, `cut`, `tr`, `jq`;
- писать идемпотентные shell scripts с проверкой ошибок и cleanup;
- собирать system inventory из `/etc`, `/proc`, `/sys` и command interfaces;
- избегать парсинга human-oriented output, когда доступен stable/machine-readable interface.

## Место в интенсиве

Все последующие спринты требуют уверенной работы в shell. Здесь shell рассматривается не как набор команд, а как язык связывания процессов, файлов и потоков данных.

## Предварительные знания

Достаточно базовой работы с командной строкой и Git.

## Основной маршрут

### Шаг 1. Модель Unix shell

Прочитать Bash Reference Manual:

- Shell Operation;
- Quoting;
- Shell Parameters;
- Shell Expansions;
- Redirections;
- Pipelines;
- Lists of Commands;
- Shell Scripts.

Источник: https://www.gnu.org/software/bash/manual/

Сформировать модель порядка: parsing → expansions → redirections → command execution → exit status.

### Шаг 2. Filesystem hierarchy и документация

Прочитать:

- `man hier` или `man file-hierarchy`;
- Debian Reference, главы о filesystem и shell;
- `man man`, `man apropos`, `man info`.

Для каталогов `/boot`, `/dev`, `/etc`, `/home`, `/proc`, `/run`, `/sys`, `/tmp`, `/usr`, `/var` определить назначение, persistence и типичные владельцы изменений.

### Шаг 3. Потоки и текстовые инструменты

Из GNU Coreutils изучить разделы для `cat`, `head`, `tail`, `cut`, `sort`, `uniq`, `tr`, `wc`, `tee`, `mktemp`.

Отдельно изучить:

- `grep` manual;
- основные address/command patterns `sed`;
- fields, records и conditions `awk`;
- `find(1)` и безопасную передачу NUL-separated names.

### Шаг 4. Надёжные scripts

Разобрать:

```bash
set -euo pipefail
trap 'cleanup' EXIT INT TERM
```

Не использовать их как магию. Для каждой option объяснить ограничения, особенно `set -e` в conditions, subshells и pipelines.

Изучить ShellCheck: https://www.shellcheck.net/

## Ресурсы

### Обязательный маршрут

- GNU Bash Reference Manual, перечисленные разделы.
- Debian Reference: shell и filesystem.
- GNU Coreutils manual для используемых commands.
- local man pages `find(1)`, `xargs(1)`, `grep(1)`, `sed(1)`, `awk(1)`.

### Альтернативные объяснения

- The Linux Command Line, William Shotts: https://linuxcommand.org/tlcl.php
- Missing Semester, Shell Tools and Scripting: https://missing.csail.mit.edu/
- BashFAQ: https://mywiki.wooledge.org/BashFAQ — сверять спорные детали с Bash manual.

### Углубление

- POSIX Shell Command Language;
- `strace` shell pipeline;
- file descriptor manipulation beyond `0/1/2`;
- process substitution and coprocesses;
- Bats tests for shell scripts.

### Справочные материалы

- https://www.gnu.org/software/coreutils/manual/coreutils.html
- https://www.gnu.org/software/grep/manual/
- https://www.gnu.org/software/gawk/manual/

## Практические задания

### 1. Карта системы

Собрать без root:

- distribution и version;
- kernel release и architecture;
- hostname и machine ID presence, не сохраняя сам ID;
- CPU count;
- total memory;
- mounted filesystems;
- block devices;
- network interfaces;
- PID 1;
- current user, groups и shell;
- uptime и boot time.

Для каждого факта указать primary interface: file в `/proc`/`/sys`, syscall-backed utility или distribution file. Не считать output одной команды внутренним устройством ОС.

### 2. Quoting matrix

Создать каталог с именами:

```text
normal
with space
with-newline
-leading-dash
*.txt
quote'file
```

Написать безопасные commands для перечисления, хеширования, копирования и удаления только этих files. Использовать `find -print0`/`xargs -0` или equivalent. Запрещено исправлять задачу переименованием files.

### 3. Pipeline semantics

Для pipeline из трёх commands создать variants, где падает первый, средний или последний command. Сравнить `$?`, `${PIPESTATUS[@]}` и `set -o pipefail`.

Показать разницу:

```bash
command >out 2>err
command >all 2>&1
command 2>&1 >out
```

### 4. Structured output

Получить JSON через `lsblk --json`, `systemctl --output=json` при поддержке или другой command. Извлечь fields через `jq`. Сравнить с попыткой парсить column-aligned output и объяснить fragility.

## Лабораторная работа

Создать `work/sysreport/` с программой `sysreport.sh`.

### Требования

Command:

```bash
./sysreport.sh --format text
./sysreport.sh --format json
./sysreport.sh --output report.json
```

Report включает:

- OS, kernel и architecture;
- boot time/uptime;
- CPU count и model summary;
- memory totals;
- root filesystem usage;
- mounts без pseudo-filesystems или с явной классификацией;
- block devices;
- network interfaces и addresses;
- failed systemd units;
- top five processes по RSS и CPU с timestamp;
- warnings, если required interfaces unavailable.

### Ограничения

- script не требует root;
- не выводит environment полностью, secrets, IP public classification, machine ID или usernames других users без необходимости;
- paths и temporary files создаются через `mktemp`;
- cleanup выполняется через `trap`;
- errors идут в stderr;
- exit status ненулевой только при невозможности сформировать обязательную часть;
- JSON валиден и проверяется `jq empty`;
- commands проверяются через `command -v`;
- human-readable output не парсится, если есть `--json`, `--bytes`, `/proc` или другой stable interface.

### Tests

Минимум:

- `shellcheck` без необоснованно отключённых diagnostics;
- запуск с изменённым `PATH`, где отсутствует optional tool;
- output file с spaces в pathname;
- invalid `--format`;
- readonly output directory;
- JSON validation;
- отсутствие temporary files после failure.

## Дополнительный эксперимент

Запустить report под `strace -f -e trace=%process,%file,%desc`. Определить, сколько процессов создаёт shell script и какие files/interfaces он читает.

Затем реализовать минимальный subset на Go и сравнить process count, error handling и portability. Не выбирать победителя только по числу syscalls.

## Самопроверка

1. Чем terminal отличается от shell?
2. Когда shell создаёт новый process, а когда выполняет builtin?
3. В каком порядке происходят expansion и redirection?
4. Почему `for f in $(find ...)` небезопасен?
5. Что означает exit status pipeline?
6. Почему `set -e` не заменяет explicit error handling?
7. Чем `/proc` отличается от обычной persistent filesystem?
8. Почему machine-readable output предпочтительнее column parsing?
9. Когда pipeline запускает commands параллельно?

Практическая проверка: получить незнакомый shell script, найти минимум пять assumptions о names, tools, privileges или output formats и исправить их tests.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Командная оболочка** — parsing, expansion, redirection, pipelines и process execution.
- **Стандартные потоки и file descriptors** — stdin/stdout/stderr и redirection semantics.
- **Filesystem hierarchy Linux** — назначение top-level directories и persistence.
- **Документация Unix-системы** — man sections, info, package docs и source of truth.
- **Надёжные shell scripts** — quoting, exit codes, temporary files, traps и idempotency.
- **procfs и sysfs** — dynamic kernel interfaces; подробности будут дополнены в спринте 02.

## Когда переходить дальше

Можно переходить, когда `sysreport.sh` проходит tests, корректно работает с unusual paths и missing optional commands, а его поля связываются с конкретными kernel/distribution interfaces.