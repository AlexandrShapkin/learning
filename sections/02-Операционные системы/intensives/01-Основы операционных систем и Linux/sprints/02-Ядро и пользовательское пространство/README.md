# Спринт 02. Ядро и пользовательское пространство

Ориентировочный объём: 10–14 часов.

## Центральный вопрос

Какие функции выполняет ядро Linux, где проходит граница с пользовательским пространством и через какие интерфейсы эту границу можно наблюдать и настраивать?

## Результат спринта

После завершения необходимо уметь:

- объяснять kernel mode и user mode;
- различать kernel, system libraries, daemons, shell и applications;
- объяснять system call как controlled kernel entry;
- различать syscall ABI и library API;
- исследовать kernel version, config, command line и taint state;
- объяснять monolithic modular kernel model Linux;
- находить loaded modules, dependencies и parameters;
- различать `/proc`, `/sys`, `/dev` и persistent configuration;
- читать и безопасно изменять sysctl с rollback;
- связывать device, driver, module и sysfs object;
- использовать `strace` для проверки границы user/kernel;
- объяснять, почему kernel panic и process crash имеют разные blast radius.

## Место в интенсиве

Спринт 01 дал инструменты исследования. Теперь строится основная модель Linux, необходимая для boot, processes, memory, filesystems, devices и isolation.

## Основной маршрут

### Шаг 1. Архитектура ОС

Прочитать OSTEP introduction и главы 2–3. Сосредоточиться на virtualization, concurrency, persistence и goals ОС.

Прочитать Debian Handbook разделы об устройстве Unix/Linux system и роли kernel.

### Шаг 2. System calls

Изучить:

- `man 2 intro`;
- `man 2 syscalls`;
- `man 2 read`, `write`, `openat`, `mmap`, `clone`, `execve` обзорно;
- TLPI chapters 1–3 либо соответствующие man pages.

Сравнить libc wrapper и raw syscall. Не писать raw assembly syscall как обязательную практику.

### Шаг 3. Kernel information interfaces

Прочитать:

- `man 5 proc`;
- `man 5 sysfs`;
- kernel admin guide: https://docs.kernel.org/admin-guide/
- sysctl docs: https://docs.kernel.org/admin-guide/sysctl/

Разобрать persistence: запись в `/proc/sys` действует runtime; постоянная настройка зависит от sysctl configuration и boot process.

### Шаг 4. Modules и drivers

Изучить local man pages:

- `lsmod(8)`;
- `modinfo(8)`;
- `modprobe(8)`;
- `depmod(8)`;
- `modules-load.d(5)`;
- `modprobe.d(5)`.

Сформировать модель kernel built-in vs loadable module. Отсутствие module в `lsmod` не доказывает отсутствие driver functionality.

## Ресурсы

### Обязательный маршрут

- OSTEP introduction и chapters 2–3.
- Linux kernel Admin Guide.
- `syscalls(2)`, `proc(5)`, `sysfs(5)`.
- kmod man pages.

### Альтернативные объяснения

- *How Linux Works*, Brian Ward, chapters kernel and devices.
- Linux Insides: https://0xax.gitbooks.io/linux-insides/ — использовать как secondary source.
- Debian Handbook, kernel chapters.

### Углубление

- build and boot a custom kernel;
- kernel source tree and Kbuild;
- ftrace and tracepoints;
- eBPF syscall tracing;
- writing a minimal out-of-tree module inside VM.

### Справочные материалы

- https://docs.kernel.org/admin-guide/kernel-parameters.html
- `uname(1)`, `dmesg(1)`, `kallsyms(5)`.

## Практические задания

### 1. Layers map

Для commands `echo hello`, `cat /etc/hostname`, `ps`, `ip addr` и Go `os.ReadFile` нарисовать path:

```text
application/builtin → library/runtime → syscall(s) → kernel subsystem → object/device
```

Проверить через `type`, `ldd`, `strace`, `/proc` и docs. Учитывать, что `echo` может быть shell builtin.

### 2. Kernel inventory

Собрать:

```bash
uname -a
cat /proc/version
cat /proc/cmdline
cat /proc/sys/kernel/tainted
zcat /proc/config.gz  # если доступно
ls /boot/config-$(uname -r)
lsmod
```

Объяснить различия release, build metadata, command line, config и runtime state.

### 3. Module dependency

Выбрать безопасный loaded module. Через `modinfo`, `/sys/module/<name>`, `lsmod` и `modprobe --show-depends` определить author/license, parameters, holders и dependencies.

Не выгружать module, используемый storage/network/VM.

### 4. Sysctl lifecycle

В отдельной network namespace изменить namespaced sysctl:

```bash
sudo unshare --net --fork bash
sysctl net.ipv4.ip_forward
sysctl -w net.ipv4.ip_forward=1
```

Проверить, что host namespace value не изменился. Отдельно найти, какие sysctl не namespaced и почему с ними требуется больше осторожности.

## Лабораторная работа

Создать `work/kernprobe/`.

### Часть A. System-call observation

Написать на Go command `kernprobe trace-target`, которая:

- открывает file;
- читает metadata и content;
- создаёт goroutine;
- открывает TCP listener на localhost;
- создаёт child process;
- выделяет и memory-maps temporary file;
- корректно закрывает resources.

Снять separate traces:

```bash
strace -ff -o traces/all ./kernprobe trace-target
strace -f -c ./kernprobe trace-target
strace -f -e trace=%file,%process,%memory,%network,%desc ./kernprobe trace-target
```

Для каждой high-level operation найти dominant syscall(s) и объяснить wrappers/runtime activity.

### Часть B. Kernel object explorer

Command `kernprobe inspect` формирует JSON:

- kernel release;
- boot command line hash или redacted form;
- selected sysctls;
- loaded modules count and selected metadata;
- filesystems supported from `/proc/filesystems`;
- devices summary from `/sys/class`;
- kernel taint state;
- LSM list, если доступно;
- cgroup mode;
- virtualization status.

Parser interfaces покрыть tests на fixture files. Не читать host-only paths напрямую в unit tests: root path должен быть configurable.

### Часть C. Runtime configuration

Создать script, который:

1. читает выбранный safe sysctl;
2. сохраняет old value;
3. меняет value в isolated namespace или VM;
4. проверяет effect;
5. восстанавливает old value через `trap`;
6. демонстрирует, что runtime change не обязательно persistent after reboot.

## Дополнительный эксперимент

Если VM имеет matching kernel headers, написать минимальный module, который только регистрирует load/unload messages и read-only parameter. Подписать risk, собрать, загрузить, проверить `dmesg`, выгрузить.

Не отключать Secure Boot или module signature enforcement ради задания. Если module loading запрещена policy, зафиксировать это как protection mechanism.

## Самопроверка

1. Почему application не может напрямую выполнить privileged instruction?
2. Чем syscall ABI отличается от libc API?
3. Почему `/proc` и `/sys` выглядят как files?
4. Чем built-in driver отличается от module?
5. Что делает `modprobe`, чего не делает простой `insmod`?
6. Почему runtime sysctl может исчезнуть после reboot?
7. Что означает tainted kernel?
8. Почему process segmentation fault обычно не приводит к kernel panic?
9. Где искать связь между device и driver?

Практическая проверка: по неизвестному `strace` определить high-level behavior процесса и назвать минимум один факт, который trace не доказывает.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Архитектура операционной системы** — kernel/user boundary и responsibilities.
- **Ядро Linux** — monolithic modular design и subsystems.
- **System call** — controlled entry, ABI, wrapper и errors.
- **procfs** — process/kernel runtime information.
- **sysfs** — kernel object/device model exposure.
- **sysctl** — runtime parameters, namespaces и persistence.
- **Kernel modules** — loading, dependencies, parameters и security implications.
- **Drivers** — связь device, bus, module и kernel subsystem.

## Когда переходить дальше

Можно переходить, когда trace-target связывается с конкретными syscalls, module/device relationships находятся через sysfs, а sysctl experiment имеет проверенный rollback и не изменяет host.