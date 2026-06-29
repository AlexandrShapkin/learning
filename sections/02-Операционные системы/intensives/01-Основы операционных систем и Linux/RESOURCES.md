# Ресурсы интенсива

Этот файл является общей библиографией. Конкретный обязательный маршрут указан в каждом спринте. Читать все источники последовательно не требуется.

## Основные книги и курсы

### Operating Systems: Three Easy Pieces

Remzi H. Arpaci-Dusseau, Andrea C. Arpaci-Dusseau. Бесплатный основной источник по virtualization, concurrency и persistence.

- книга и главы: https://pages.cs.wisc.edu/~remzi/OSTEP/
- код и homework: https://pages.cs.wisc.edu/~remzi/OSTEP/Code/

В этом интенсиве OSTEP используется для механизмов. Практическое администрирование строится по Linux documentation и Debian Handbook.

### The Linux Programming Interface

Michael Kerrisk. Основной справочник по Linux/Unix system programming: processes, signals, users, files, memory mappings, terminals, IPC, sockets и namespaces.

Книга коммерческая. Сайт автора и Linux man-pages: https://man7.org/tlpi/

В спринтах указаны главы, но обязательную часть можно заменить соответствующими man pages.

### The Debian Administrator's Handbook

Бесплатный системный маршрут по package management, services, network, storage, security и maintenance.

- английская версия: https://www.debian.org/doc/manuals/debian-handbook/
- русская версия: https://www.debian.org/doc/manuals/debian-handbook/index.ru.html

### Debian Reference

Практический справочник по shell, filesystem, packages, networking, storage и system administration:

- https://www.debian.org/doc/manuals/debian-reference/

### GNU manuals

- Bash Reference Manual: https://www.gnu.org/software/bash/manual/
- GNU Coreutils: https://www.gnu.org/software/coreutils/manual/coreutils.html
- GNU grep: https://www.gnu.org/software/grep/manual/
- GNU sed: https://www.gnu.org/software/sed/manual/
- GNU awk/gawk: https://www.gnu.org/software/gawk/manual/

## Linux kernel и системные интерфейсы

- Latest kernel documentation: https://docs.kernel.org/
- Admin guide: https://docs.kernel.org/admin-guide/
- Core API: https://docs.kernel.org/core-api/
- Memory management: https://docs.kernel.org/admin-guide/mm/
- Filesystems: https://docs.kernel.org/filesystems/
- Block layer: https://docs.kernel.org/block/
- Networking: https://docs.kernel.org/networking/
- Userspace API: https://docs.kernel.org/userspace-api/
- Kernel parameters: https://docs.kernel.org/admin-guide/kernel-parameters.html
- sysctl: https://docs.kernel.org/admin-guide/sysctl/
- cgroup v2: https://docs.kernel.org/admin-guide/cgroup-v2.html

## Linux man-pages

Основной индекс: https://man7.org/linux/man-pages/

Особенно часто используются:

- `intro(2)`, `syscalls(2)`, `proc(5)`, `sysfs(5)`;
- `fork(2)`, `execve(2)`, `wait(2)`, `clone(2)`;
- `signal(7)`, `credentials(7)`, `capabilities(7)`;
- `inode(7)`, `path_resolution(7)`, `mount(2)`, `mount_namespaces(7)`;
- `mmap(2)`, `madvise(2)`, `proc_pid_smaps(5)`;
- `namespaces(7)`, `cgroups(7)`, `user_namespaces(7)`;
- `socket(7)`, `ip(7)`, `tcp(7)`, `udp(7)`.

## systemd

Официальные man pages: https://www.freedesktop.org/software/systemd/man/latest/

Основные документы:

- `bootup(7)`;
- `systemd(1)`;
- `systemd.unit(5)`;
- `systemd.service(5)`;
- `systemd.exec(5)`;
- `systemd.resource-control(5)`;
- `systemd.timer(5)`;
- `systemd.time(7)`;
- `systemctl(1)`;
- `journalctl(1)`;
- `journald.conf(5)`;
- `systemd-analyze(1)`;
- `systemd.special(7)`.

## Boot

- UEFI specification portal: https://uefi.org/specifications
- GNU GRUB manual: https://www.gnu.org/software/grub/manual/grub/
- Debian installation guide: https://www.debian.org/releases/stable/installmanual
- Debian release notes: https://www.debian.org/releases/stable/releasenotes
- kernel initramfs documentation and distribution tools: local `man initramfs-tools`, `man update-initramfs`.

## Packages

- APT User's Guide: https://www.debian.org/doc/manuals/apt-guide/
- Debian Handbook, APT chapter: https://www.debian.org/doc/manuals/debian-handbook/apt.html
- Debian Policy: https://www.debian.org/doc/debian-policy/
- `apt(8)`, `apt-get(8)`, `apt-cache(8)`, `apt_preferences(5)`, `sources.list(5)`;
- `dpkg(1)`, `dpkg-query(1)`, `deb(5)`, `deb-control(5)`.

## Storage и filesystems

- util-linux man pages: `lsblk(8)`, `findmnt(8)`, `mount(8)`, `fdisk(8)`, `wipefs(8)`;
- e2fsprogs documentation and local man pages;
- XFS documentation: https://docs.kernel.org/filesystems/xfs.html
- Btrfs documentation: https://btrfs.readthedocs.io/
- LVM2 resources: https://sourceware.org/lvm2/
- device-mapper: https://docs.kernel.org/admin-guide/device-mapper/

## Networking

- iproute2 documentation and man pages: https://www.kernel.org/pub/linux/utils/net/iproute2/
- `ip(8)`, `ss(8)`, `tc(8)`;
- NetworkManager documentation: https://networkmanager.dev/docs/
- systemd-networkd/resolved man pages;
- resolver man pages: `resolv.conf(5)`, `nsswitch.conf(5)`, `getaddrinfo(3)`;
- nftables project: https://www.netfilter.org/projects/nftables/
- nftables documentation: https://www.netfilter.org/documentation/

Протоколы Ethernet, IP, TCP, DNS и TLS подробно изучаются в отдельном разделе. Здесь рассматривается конфигурация и диагностика ОС.

## Security

- Debian security documentation: https://www.debian.org/security/
- Securing Debian Manual: https://www.debian.org/doc/manuals/securing-debian-manual/
- OpenSSH manuals: https://www.openssh.com/manual.html
- Linux-PAM documentation: https://github.com/linux-pam/linux-pam/tree/master/doc
- Linux Audit documentation: local `man auditctl`, `man ausearch`, `man audit.rules`;
- capabilities: https://man7.org/linux/man-pages/man7/capabilities.7.html
- Landlock userspace API: https://docs.kernel.org/userspace-api/landlock.html
- seccomp userspace API: https://docs.kernel.org/userspace-api/seccomp_filter.html

## Диагностика

- procps-ng commands: `ps`, `top`, `free`, `vmstat`, `watch`;
- sysstat: `sar`, `pidstat`, `iostat`, `mpstat`;
- `strace`, `lsof`, `fuser`, `ss`, `tcpdump`;
- `perf`: https://perf.wiki.kernel.org/
- Brendan Gregg, Linux performance tools: https://www.brendangregg.com/linuxperf.html
- systemd tools: `journalctl`, `systemd-analyze`, `coredumpctl`;
- filesystem repair tools are documented in their local man pages.

## Дополнительные источники

### ArchWiki

https://wiki.archlinux.org/

Используется как качественное практическое объяснение boot, systemd, users, storage, networking и security. Команды и defaults обязательно сверяются с Debian и upstream documentation.

### Linux From Scratch

https://www.linuxfromscratch.org/

Полезно для углубления в bootstrapping пользовательского пространства и взаимосвязь packages, libraries, kernel и init system. Полная сборка LFS не входит в основной интенсив.

## Правило использования

1. Начинать с обязательных глав конкретного спринта.
2. Проверять изменчивые детали по локальной man page и upstream docs.
3. Использовать ArchWiki и статьи как вторичное объяснение, а не единственный источник истины.
4. Не копировать full logs, books или downloaded packages в repository.
5. При расхождении tutorial и фактической системы доверять измеряемому состоянию, man page установленной версии и official documentation.