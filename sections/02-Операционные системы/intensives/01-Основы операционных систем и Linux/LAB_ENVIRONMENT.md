# Лабораторное окружение

Интенсив содержит эксперименты с загрузкой, storage, firewall, PAM, SSH, cgroups и recovery. Выполнять их на основной рабочей машине не следует.

## Эталонная схема

Использовать одну основную VM и rescue ISO.

```text
host
└── linux-os-lab
    ├── system disk: 30 GiB
    ├── data disk A: 8 GiB
    ├── data disk B: 8 GiB
    ├── 2–4 vCPU
    ├── 4–8 GiB RAM
    ├── NAT network
    └── optional isolated network
```

Эталонный guest — Debian 13 amd64 minimal install с systemd. Официальные образы и checksums: https://www.debian.org/distrib/

Современный Ubuntu, Fedora или другой systemd-based Linux допустим. При расхождении commands необходимо сверяться с документацией конкретного distribution и сохранять отличие как observation.

## Почему VM обязательна

VM позволяет безопасно:

- ломать `/etc/fstab`, initramfs и systemd units;
- экспериментировать с partitions, LVM и filesystems;
- ограничивать память до OOM;
- менять firewall и SSH;
- загружаться в rescue/emergency mode;
- восстанавливать snapshot вместо ручного ремонта host.

## Snapshot points

Создавать snapshots с понятными именами:

```text
00-clean-install
01-base-tools
02-before-boot-lab
03-before-storage-lab
04-before-security-lab
05-before-final-incidents
```

Snapshots являются страховкой, а не заменой recovery practice. В заданиях восстановления сначала попытаться исправить систему, затем использовать snapshot только при невозможности продолжить.

## Начальная установка

После минимальной установки:

```bash
sudo apt update
sudo apt full-upgrade
sudo apt install \
  build-essential git curl wget ca-certificates \
  vim tmux jq tree less man-db manpages manpages-dev \
  procps psmisc lsof strace ltrace gdb file \
  iproute2 nftables dnsutils tcpdump netcat-openbsd \
  sysstat stress-ng fio iotop-c \
  lvm2 acl attr xfsprogs btrfs-progs e2fsprogs \
  auditd shellcheck python3 python3-venv \
  qemu-guest-agent
```

Некоторые packages могут называться иначе в другом distribution. Скрипт проверки сообщает фактическое наличие commands.

Для Go установить текущую поддерживаемую версию официальным способом или package manager. Интенсив не зависит от конкретной minor version.

## Дополнительные виртуальные диски

Диски A и B должны быть пустыми. Перед каждым storage experiment:

```bash
lsblk -o NAME,PATH,SIZE,TYPE,FSTYPE,MOUNTPOINTS,MODEL,SERIAL
findmnt
sudo blkid
```

В README конкретной лаборатории записать выбранные paths. Никогда не копировать `/dev/sdb` из инструкции без проверки собственной VM.

## Сеть

NAT используется для package downloads. Для networking sprint рекомендуется вторая network interface в isolated/host-only network.

Не публиковать vulnerable test services в Internet. SSH слушает только private/NAT interface лаборатории.

## Rescue environment

Подключить Debian installer ISO или live/rescue image. Проверить до destructive exercises, что доступны:

- shell;
- `lsblk`, `mount`, `chroot`;
- filesystem check utilities;
- network, если нужен package repair;
- bootloader tools.

## Хранение результатов

Внутри каждого спринта создаётся `work/` только при начале практики. Коммитить:

- source и tests;
- небольшие scripts и unit files;
- sanitized configs;
- concise observations;
- selected small logs;
- commands for regeneration.

Не коммитить:

- VM disks и snapshots;
- installation ISO;
- private SSH keys;
- `/etc/shadow` и password hashes;
- full journal archives;
- real IPs, hostnames и user data;
- core dumps и large traces.