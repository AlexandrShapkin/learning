# Спринт 03. Загрузка системы и systemd

Ориентировочный объём: 12–16 часов.

## Центральный вопрос

Какая последовательность приводит выключенную машину к работающим службам и как найти этап, на котором загрузка остановилась или замедлилась?

## Результат спринта

После завершения необходимо уметь:

- объяснять роли firmware, UEFI/BIOS, bootloader, kernel, initramfs и PID 1;
- находить EFI System Partition, boot entries и kernel command line;
- объяснять назначение initramfs;
- различать kernel boot и userspace boot;
- читать systemd unit dependency graph;
- различать enable, start, wants, requires, before и after;
- объяснять targets, services, mounts, devices, sockets и timers;
- анализировать current/previous boot через journal;
- использовать `systemd-analyze` для critical path;
- загружаться в rescue/emergency target;
- создавать безопасный unit и диагностировать его failure;
- планировать rollback boot configuration.

## Место в интенсиве

После модели kernel/user space рассматривается момент их последовательного запуска. Systemd будет использоваться далее для services, logs, timers, cgroups и recovery.

## Основной маршрут

### Шаг 1. Boot chain

Прочитать:

- Debian Installation Guide sections о boot process;
- GNU GRUB manual introduction и configuration overview;
- `man 7 bootup`;
- kernel docs о command-line parameters обзорно.

Сравнить legacy BIOS и UEFI только на уровне chain of trust and handoff. Практика выполняется на фактическом firmware mode VM.

### Шаг 2. Kernel и initramfs

Изучить:

- `/boot` contents;
- `/proc/cmdline`;
- `lsinitramfs` и `update-initramfs` local docs;
- `dmesg` timestamps;
- `journalctl -k -b`.

Понять, зачем drivers, storage discovery и early userspace могут находиться в initramfs.

### Шаг 3. systemd transaction model

Прочитать official man pages:

- `systemd(1)`;
- `systemd.unit(5)`;
- `systemd.service(5)`;
- `systemd.special(7)`;
- `systemctl(1)`;
- `bootup(7)`.

Особое внимание: ordering dependency не равна requirement dependency.

### Шаг 4. Boot analysis и recovery targets

Изучить:

```bash
systemd-analyze time
systemd-analyze blame
systemd-analyze critical-chain
systemd-analyze plot
systemctl list-dependencies
journalctl --list-boots
journalctl -b -1
```

Прочитать `systemd.unit=rescue.target`, `emergency.target` и `systemd.debug_shell` docs. Debug shell не оставлять enabled.

## Ресурсы

### Обязательный маршрут

- systemd official man pages `bootup`, `unit`, `service`, `systemctl`.
- GNU GRUB manual overview.
- Debian installation/recovery documentation.
- local initramfs tools documentation.

### Альтернативные объяснения

- ArchWiki: Arch boot process и systemd — сверять paths/config with Debian.
- *How Linux Works*, chapters boot and init.
- Linux From Scratch, boot scripts/systemd overview.

### Углубление

- Secure Boot and measured boot;
- unified kernel images;
- dracut;
- systemd generators;
- initramfs debugging shell;
- bootloader specification.

### Справочные материалы

- `efibootmgr(8)`;
- `kernel-command-line(7)`;
- `systemd.generator(7)`;
- `systemd-analyze(1)`.

## Практические задания

### 1. Boot map

На своей VM определить:

- firmware mode;
- partition containing bootloader/ESP;
- bootloader config source;
- selected kernel and initramfs;
- kernel command line;
- PID 1 executable;
- default target;
- units on critical path.

Каждый пункт подтвердить command output или file path.

### 2. Initramfs inspection

Вывести список initramfs contents и найти:

- init entry;
- storage/filesystem modules;
- udev/systemd components;
- root-device discovery logic.

Сравнить size и contents с installed kernel modules. Не распаковывать в repository.

### 3. Dependency semantics

Создать diagram для units A, B, C:

- A `Requires=B` и `After=B`;
- A `Wants=C`, но без ordering;
- B fails;
- C starts slowly.

До проверки предсказать transaction. Реализовать three temporary units и сверить `systemctl show`, journal и ordering timestamps.

### 4. Previous boot

После normal reboot собрать:

- kernel messages current/previous boot;
- boot duration;
- failed units;
- shutdown sequence;
- one device discovery event.

Объяснить, когда previous journal недоступен из-за volatile storage.

## Лабораторная работа

Создать `work/bootlab/`.

### Service topology

Подготовить:

```text
bootlab-prepare.service
bootlab-worker.service
bootlab-ready.target
bootlab.path
```

- prepare создаёт runtime directory через systemd-supported mechanism;
- worker запускает небольшой Go program и ждёт input file;
- path unit активирует обработку;
- target объединяет готовое состояние;
- units используют explicit dependencies и ordering;
- logs идут в journal;
- uninstall script полностью удаляет laboratory units.

### Диагностические сценарии

1. `ExecStart` указывает на отсутствующий binary.
2. Working directory недоступен service user.
3. Unit имеет ordering, но не requirement dependency.
4. Service ожидает network-online без реальной необходимости.
5. Unit изменён, но daemon-reload не выполнен.
6. Restart loop ограничен start rate limiting.

Для каждого сценария:

- предсказать observable failure;
- воспроизвести;
- найти evidence через `systemctl status`, `show`, `journalctl`, dependency graph;
- исправить минимальным change;
- проверить cleanup.

### Boot timing

Добавить deliberate 3-second delay в отдельный oneshot unit, включить в custom target и доказать, влияет ли он на boot critical chain. Затем убрать dependency и сравнить.

## Дополнительный эксперимент

После snapshot выполнить one-time boot в `rescue.target`, затем `emergency.target`. Проверить mounted filesystems, network, active units и available tools.

Дополнительно временно передать harmless kernel parameter и найти его в `/proc/cmdline`. Не изменять persistent GRUB config без rollback.

## Самопроверка

1. Где заканчивается firmware и начинается bootloader?
2. Зачем нужен initramfs, если kernel уже запущен?
3. Что запускает PID 1?
4. Чем `systemctl enable` отличается от `start`?
5. Почему `After=` не означает `Requires=`?
6. Что такое systemd transaction?
7. Почему `network-online.target` часто используют неправильно?
8. Как найти previous boot failure?
9. Чем rescue target отличается от emergency target?
10. Как плохой `/etc/fstab` может задержать boot?

Практическая проверка: получить failing unit и boot journal, определить earliest causal failure, отделив его от последующих dependency failures.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Загрузка Linux** — firmware → bootloader → kernel → initramfs → init.
- **UEFI и bootloader** — boot entries, ESP и handoff.
- **Initramfs** — early userspace, drivers и root discovery.
- **systemd** — manager, units, transaction and dependency model.
- **systemd targets** — synchronization points and boot states.
- **Анализ загрузки** — journal, critical chain и failure propagation.
- **Rescue и emergency mode** — capabilities, use cases и risks.

## Когда переходить дальше

Можно переходить, когда boot path своей VM подтверждён evidence, temporary unit topology работает и удаляется, а failures диагностируются через dependency semantics, а не подбором случайных commands.