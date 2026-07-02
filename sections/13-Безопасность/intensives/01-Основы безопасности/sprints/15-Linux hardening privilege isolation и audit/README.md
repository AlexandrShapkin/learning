# Спринт 15. Linux hardening, privilege isolation и audit

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Как уменьшить привилегии и поверхность атаки Linux-сервиса, сохранив управляемость и диагностируемость?

## Результат спринта

После завершения необходимо уметь:

- inventory users, groups, services, ports and privileged files;
- apply least-privilege service accounts and file permissions;
- use capabilities instead of full root where justified;
- configure systemd sandboxing and resource limits conceptually/practically;
- understand namespaces, seccomp, AppArmor/SELinux roles;
- harden SSH and administrative access;
- manage patches and secure boot/package trust at overview level;
- configure audit events for sensitive operations;
- preserve break-glass and recovery access safely;
- verify hardening without relying on benchmark score alone.

## Основной маршрут

1. Inventory a disposable Linux host and service.
2. Remove unnecessary users, packages, ports and privileges.
3. Run the service as a dedicated account with restrictive systemd unit.
4. Add selected capabilities/seccomp/AppArmor or equivalent controls.
5. Add audit rules and test authorized/denied operations.

## Лабораторная работа

Создать `work/linux-hardening/`.

### Requirements

- service runs without root and with minimal filesystem/network access;
- sensitive files have least-privilege ownership/modes;
- privileged capabilities are individually justified;
- systemd or equivalent sandbox denies unneeded namespaces/devices/paths;
- SSH uses key-based administration and restricted privileged login;
- audit events cover identity, privilege and protected-file changes;
- patch/reboot strategy and rollback are documented;
- hardening does not remove observability or emergency recovery without replacement;
- one baseline recommendation is rejected due workload evidence.

### Failure scenarios

1. Service runs as root for convenience.
2. Secret/config is world-readable.
3. Broad sudo rule permits shell escape.
4. Unused listening service remains enabled.
5. Audit logs can be modified by service account.
6. Hardening blocks health/recovery and is disabled globally.
7. Shared admin account prevents attribution.

## Результат для базы знаний

- **Linux service hardening and attack-surface reduction**.
- **Linux capabilities and least privilege**.
- **Systemd sandboxing and resource isolation**.
- **Linux MAC and seccomp roles**.
- **Linux security auditing and administrative access**.

## Когда переходить дальше

Можно переходить, когда the service operates under minimal verified privileges and sensitive administrative actions are attributable and recoverable.