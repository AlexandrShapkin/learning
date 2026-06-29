# Основы операционных систем и Linux

Основной интенсив раздела «Операционные системы». Linux используется как практическая платформа, но каждый спринт отделяет общий механизм операционной системы от конкретного интерфейса дистрибутива.

## Результат прохождения

После завершения необходимо уметь самостоятельно:

- объяснить назначение операционной системы, ядра, системных вызовов, библиотек и пользовательского пространства;
- исследовать kernel, modules, sysctl, `/proc`, `/sys` и device nodes;
- проследить boot chain и восстановить систему при ошибке загрузки;
- управлять процессами, сигналами, job control, scheduling, priorities и limits;
- диагностировать memory pressure, swap activity, leaks и OOM kills;
- объяснить inode, directory entry, links, permissions, ACL и capabilities;
- создавать и обслуживать filesystems, mounts, swap и LVM на disposable devices;
- исследовать udev, block/character devices и I/O paths;
- управлять users, groups, sudo и PAM без нарушения принципа least privilege;
- безопасно работать с APT, repositories, package metadata и обновлениями;
- создавать, ограничивать и диагностировать systemd services и timers;
- находить события через journal, syslog, logrotate и coredump tools;
- настраивать и диагностировать interfaces, routes, DNS, sockets и nftables;
- применять namespaces и cgroup v2 напрямую, без сведения контейнеров к Docker CLI;
- выполнять базовый hardening, управлять SSH и проверять audit evidence;
- восстанавливать систему после повреждения unit, `/etc/fstab`, package state, boot configuration или filesystem;
- проводить сквозную диагностику неизвестной Linux-системы доказательно и с минимальным риском.

Целевой уровень: 3 по всему разделу и 4 по процессам, памяти, файловым системам, systemd, диагностике и восстановлению.

## Границы

Интенсив не заменяет:

- углублённую разработку ядра и драйверов;
- профессиональную сетевую инженерию;
- администрирование конкретного enterprise-дистрибутива во всём объёме;
- Kubernetes, configuration management и fleet orchestration;
- специализированную forensic analysis;
- полную программу security engineering.

Практика выполняется на одной Linux-машине и нескольких локальных namespaces/VM. Distributed operations рассматриваются в других разделах.

## Предварительные знания

Рекомендуется завершить основной интенсив [«Основы вычислительных систем»](../../../01-Вычислительные%20системы/intensives/01-Основы%20вычислительных%20систем/) либо уверенно понимать:

- процессы и потоки;
- virtual memory и page cache;
- system calls и file descriptors;
- basic networking;
- block I/O;
- namespaces и cgroups на обзорном уровне.

Также необходимы базовые Git и Go. Большая часть практики выполняется в shell; небольшие helper-программы пишутся на Go или C.

## Лабораторное окружение

Эталонная платформа — Debian 13 на x86-64 в виртуальной машине с systemd и cgroup v2. Допустим современный Fedora, Ubuntu или другой systemd-based дистрибутив, но package manager, paths и defaults могут отличаться.

Подробная схема лаборатории находится в [`LAB_ENVIRONMENT.md`](LAB_ENVIRONMENT.md).

Минимально требуется:

- 2 vCPU;
- 4 GiB RAM;
- 30 GiB системного диска;
- два дополнительных disposable virtual disks по 4–8 GiB;
- NAT-сеть и возможность создать host-only/internal network;
- snapshot перед destructive или recovery experiments;
- rescue ISO или live environment.

Проверка инструментов:

```bash
bash scripts/check-environment.sh
```

## Правила безопасности

1. Все storage, boot, firewall, PAM, SSH и recovery experiments выполняются в disposable VM.
2. Перед изменением bootloader, initramfs, `/etc/fstab`, PAM или firewall создаётся snapshot.
3. Команда над block device выполняется только после проверки `lsblk`, `findmnt` и device serial/size.
4. SSH/firewall changes сначала проверяются во втором активном session.
5. Нельзя отключать security controls только для прохождения задания без явного возврата конфигурации.
6. Credentials, private keys, machine IDs, real logs и secrets не коммитятся.
7. Destructive commands в README спринтов ограничены test devices или специально созданными images.

## Правила прохождения

1. Спринты проходятся по порядку.
2. Основной маршрут ресурсов обязателен; альтернативы используются при необходимости.
3. До изменения системы фиксируется прогноз и способ отката — обычно одной короткой секцией в `work/README.md` или comments script.
4. Сохраняются только команды воспроизведения, небольшие configs, tests и существенные observations.
5. Полные command transcripts и скриншоты каждого шага не требуются.
6. Проверочные спринты выполняются без повторного чтения до первой попытки.
7. Обобщённые знания переносятся в `knowledge`, а machine-specific outputs остаются в `work/`.
8. Любое исправление должно иметь evidence: journal entry, process state, metric, config diff, mount table, packet capture или test.

## Порядок спринтов

1. [Linux, оболочка и исследование системы](sprints/01-Linux%20оболочка%20и%20исследование%20системы/) — filesystem hierarchy, shell, streams, pipelines и документация.
2. [Ядро и пользовательское пространство](sprints/02-Ядро%20и%20пользовательское%20пространство/) — kernel, syscalls, modules, procfs, sysfs и sysctl.
3. [Загрузка системы и systemd](sprints/03-Загрузка%20системы%20и%20systemd/) — firmware, bootloader, kernel, initramfs, PID 1 и units.
4. [Процессы, сигналы и job control](sprints/04-Процессы%20сигналы%20и%20job%20control/) — lifecycle, process tree, sessions, signals и terminal jobs.
5. [Планирование, приоритеты и limits](sprints/05-Планирование%20приоритеты%20и%20limits/) — scheduler, nice, affinity, rlimits и accounting.
6. [Проверка основания Linux](sprints/06-Проверка%20основания%20Linux/) — перенос знаний первых пяти спринтов.
7. [Память, swap, pressure и OOM](sprints/07-Память%20swap%20pressure%20и%20OOM/) — memory accounting, reclaim, swap и OOM killer.
8. [Файлы, inode, ссылки и права](sprints/08-Файлы%20inode%20ссылки%20и%20права/) — VFS view, metadata, permissions, ACL, umask и special bits.
9. [Файловые системы, mounts и storage layers](sprints/09-Файловые%20системы%20mounts%20и%20storage%20layers/) — partitions, filesystems, mount namespaces, swap и LVM.
10. [Проверка памяти и хранения](sprints/10-Проверка%20памяти%20и%20хранения/) — сквозная диагностика memory/filesystem/storage.
11. [Устройства, udev и ввод-вывод](sprints/11-Устройства%20udev%20и%20ввод-вывод/) — device model, `/dev`, events, permissions и I/O observation.
12. [Пользователи, группы и привилегии](sprints/12-Пользователи%20группы%20и%20привилегии/) — identity, sudo, PAM, ACL и capabilities.
13. [Пакеты и жизненный цикл программ](sprints/13-Пакеты%20и%20жизненный%20цикл%20программ/) — dpkg, APT, repositories, dependencies, upgrades и verification.
14. [Службы, журналы и планирование задач](sprints/14-Службы%20журналы%20и%20планирование%20задач/) — service units, journal, logrotate, timers и coredumps.
15. [Сеть и разрешение имён в Linux](sprints/15-Сеть%20и%20разрешение%20имён%20в%20Linux/) — links, addresses, routes, DNS, sockets и nftables.
16. [Namespaces, cgroups и изоляция](sprints/16-Namespaces%20cgroups%20и%20изоляция/) — isolated views, resource control и minimal container environment.
17. [Безопасность и удалённое администрирование](sprints/17-Безопасность%20и%20удалённое%20администрирование/) — SSH, hardening, audit, updates и least privilege.
18. [Проверка эксплуатации](sprints/18-Проверка%20эксплуатации/) — комплексный service/network/security incident.
19. [Диагностика и восстановление](sprints/19-Диагностика%20и%20восстановление/) — structured troubleshooting, rescue mode и rollback.
20. [Итоговая работа](sprints/99-Итоговая%20работа/) — построение и восстановление диагностируемого Linux-хоста.

## Покрытие основных вопросов раздела

| Основной вопрос | Спринты |
|---|---|
| Как ОС управляет аппаратными ресурсами? | 02, 04–05, 07, 11 |
| Чем ядро отличается от user space? | 01–02 |
| Что происходит при запуске системы? | 03 |
| Как создаются, выполняются и завершаются процессы? | 04–05 |
| Как распределяются CPU и память? | 05, 07, 16 |
| Как организованы файлы и каталоги? | 08–09 |
| Как работают users, groups и permissions? | 08, 12 |
| Как запускаются и контролируются services? | 03, 14 |
| Как программа взаимодействует с files, network и devices? | 02, 11, 15 |
| Как диагностировать load, memory shortage и full disk? | 07, 09–10, 18–19 |
| Какие Linux mechanisms используются контейнерами? | 16 |
| Как восстановить систему после ошибки или отказа? | 03, 10, 18–19, 99 |

Таблица является частью готового проекта и не требует ручного сопровождения.

## Итоговая работа

Итогом станет VM `linux-host-lab` с небольшим Go-сервисом, отдельным data volume, systemd units, users, firewall, monitoring scripts, backup и recovery runbook.

В ходе итогового спринта потребуется:

- собрать и установить package-like artifact;
- создать least-privilege service account;
- настроить systemd service, timer, journaling и resource limits;
- подготовить storage через LVM/filesystem/mount;
- настроить network и nftables;
- ограничить service через namespaces/cgroups/systemd sandboxing;
- воспроизвести минимум восемь неисправностей;
- восстановить систему из rescue environment;
- доказать причины через logs, process state, resource metrics и config diffs;
- перенести общие выводы в базу знаний.

## Вклад в базу знаний

Каждый спринт содержит список рекомендуемых заметок, их главный вопрос, границы и связи. Отдельный backlog не используется.

Можно оформлять заметки после каждого спринта или группами после checkpoints. Практические dumps, machine-specific paths и временные recovery notes остаются в `learning`.

## Общая библиография

Основные и справочные источники собраны в [`RESOURCES.md`](RESOURCES.md). В каждом спринте указаны конкретные главы и man pages.

## Продолжение

После прохождения логично перейти к «Сетям и протоколам», «Инфраструктуре и платформам», «Доставке и эксплуатации» или тематическому углублению по Linux internals, performance, storage либо security.