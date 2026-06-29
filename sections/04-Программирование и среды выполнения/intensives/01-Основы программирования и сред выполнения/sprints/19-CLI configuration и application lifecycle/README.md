# Спринт 19. CLI, configuration и application lifecycle

Ориентировочный объём: 13–19 часов.

## Центральный вопрос

Как превратить library/runtime mechanisms в предсказуемое приложение с устойчивым command interface, configuration contract, startup/shutdown lifecycle и безопасной эксплуатацией?

## Результат спринта

После завершения необходимо уметь:

- проектировать CLI as stable interface for humans and scripts;
- использовать subcommands, flags, positional arguments and stdin/stdout/stderr consistently;
- define exit codes and machine-readable output;
- implement configuration precedence: defaults → file → environment → flags;
- distinguish absent, empty and zero values;
- validate complete configuration before side effects;
- redact secrets and avoid leaking environment/config to logs;
- support help/version/build info;
- design startup phases and rollback partial initialization;
- handle signals, cancellation, graceful drain and forced stop;
- define readiness versus liveness at application level;
- use structured logs with stable event fields without over-logging;
- create pid/lock/socket/state files safely where needed;
- separate command parsing, application orchestration and domain logic;
- make daemon/service runnable under systemd without daemonizing itself;
- test CLI and lifecycle through subprocess/integration tests;
- diagnose config-source conflict, startup partial failure and shutdown hang.

## Основной маршрут

### Шаг 1. Command interface

Study POSIX/GNU conventions and Go `flag` or selected minimal CLI library. Define:

- command grammar;
- output contract;
- errors/exit codes;
- compatibility expectations;
- completion/help optional.

Do not add dependency only for decorative CLI features.

### Шаг 2. Configuration

Represent each source explicitly and merge deterministically. Validate after merge, before opening listeners/files. Secrets use file descriptor/file/secret store patterns where practical, not command-line arguments by default.

### Шаг 3. Application lifecycle

Use phases:

```text
parse → load → merge → validate → initialize resources
→ mark ready → serve/work → drain → close → exit
```

Each acquired resource has ownership and reverse-order cleanup.

### Шаг 4. Service integration

Run foreground, log to stdout/stderr, react to SIGTERM, expose readiness/health and optional systemd notify only as extension.

## Ресурсы

### Обязательный маршрут

- Go `flag`, `os`, `os/signal`, `context`, `runtime/debug` docs.
- POSIX utility conventions.
- systemd service execution/lifecycle docs from OS intensive.
- Go build info docs.

### Альтернативные объяснения

- Twelve-Factor configuration section with critical limitations.
- Cobra/urfave docs only if selected after stdlib evaluation.

### Углубление

- dynamic configuration reload;
- feature flags;
- secrets managers;
- systemd socket activation;
- Windows service lifecycle;
- plugin/config schema migration.

## Практические задания

### 1. CLI contract

Design command with text/JSON output and errors. Test stdout/stderr/exit code exactly through subprocess.

### 2. Precedence

Generate combinations of defaults/file/env/flags. Property-test precedence and absent/empty/zero distinctions.

### 3. Partial startup

Initialize three resources; inject failure in each phase and prove already-opened resources close in reverse order without starting service.

### 4. Graceful shutdown

Run active work, send SIGTERM, stop accepting new work, wait bounded time, cancel remaining work, flush/close and exit with documented status.

## Лабораторная работа

Create `work/app-lifecycle/`:

```text
cmd/appd/
cmd/appctl/
internal/config/
internal/app/
internal/lifecycle/
internal/health/
```

### `appd`

- foreground service;
- local HTTP or Unix-socket control endpoint;
- background worker queue;
- config file/env/flags;
- `/live`, `/ready`, `/status`;
- structured logs;
- graceful shutdown/reload optional.

### `appctl`

- status, submit, drain and version commands;
- JSON output;
- stable exit codes;
- timeouts.

### Requirements

- one config schema with defaults and source metadata;
- unknown config fields rejected or explicitly handled;
- secret values redacted;
- startup validation before listener/data mutation;
- resource cleanup stack;
- readiness only after dependencies initialized;
- bounded shutdown;
- version/build/module info;
- subprocess tests for CLI and signals;
- no daemon fork/double-fork;
- example systemd unit stored as artifact, not installed globally.

### Failure scenarios

1. Invalid flag/config syntax.
2. Unknown/deprecated field.
3. Empty env overrides valid default unexpectedly.
4. Secret exposed in error/log/process args.
5. Listener opens before validation then remains leaked.
6. Dependency initializes partially.
7. Readiness becomes true too early.
8. SIGTERM ignored or work never drains.
9. Double signal requires forced stop.
10. Config reload applies half of changes.
11. CLI JSON polluted by logs.
12. Version metadata missing/stale.

## Дополнительный эксперимент

Add systemd socket activation or `sd_notify` readiness and compare lifecycle ownership with ordinary listener creation.

## Самопроверка

1. What makes CLI an API?
2. Why separate stdout/stderr?
3. How should precedence be defined?
4. Absent versus empty versus zero?
5. Why validate before side effects?
6. What is resource ownership during startup?
7. Readiness versus liveness?
8. What is graceful shutdown?
9. Why daemon should normally stay foreground under supervisor?
10. How to prevent secret leakage?
11. What must config reload guarantee?
12. How are exit codes tested?

Практическая проверка: given startup/shutdown logs and process/fd state, identify validation, ownership, readiness or drain defect.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Command-line interface as contract**.
- **Configuration sources and precedence**.
- **Configuration validation and secret handling**.
- **Application startup phases**.
- **Graceful shutdown and draining**.
- **Readiness and liveness**.
- **Structured application logs**.
- **Service process under systemd**.
- **Build/version information**.

## Когда переходить дальше

Можно переходить, когда appd/appctl pass subprocess and signal tests, partial startup leaves no resources, and configuration/output contracts are deterministic.