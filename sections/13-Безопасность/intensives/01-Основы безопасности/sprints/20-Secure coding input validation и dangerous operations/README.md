# Спринт 20. Secure coding, input validation и dangerous operations

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как обрабатывать недоверенные данные и опасные операции так, чтобы validation, canonicalization and safe APIs prevented injection, traversal and unintended resource access?

## Результат спринта

После завершения необходимо уметь:

- define trust boundary and input contract;
- distinguish validation, normalization, canonicalization and encoding;
- use allowlists and typed parsing where appropriate;
- prevent SQL, command, template and path injection;
- use parameterized queries and safe process APIs;
- validate files, URLs, archives and resource identifiers;
- handle errors without leaking secrets or internals;
- apply size, depth, time and resource limits;
- avoid unsafe deserialization and dynamic evaluation;
- write negative and property/fuzz tests for security invariants;
- review concurrency/race effects on authorization and validation.

## Основной маршрут

1. Inventory all external inputs in API, worker and file flows.
2. Replace concatenated SQL/commands/templates with safe APIs.
3. Add canonical path and archive extraction checks.
4. Bound request/body/file/parser resources.
5. Add negative and fuzz tests.

## Лабораторная работа

Создать `work/secure-coding/`.

### Requirements

- every input has type, size and semantic constraints;
- database queries are parameterized;
- commands use fixed executable/arguments without shell interpolation;
- file access remains inside explicit root after canonicalization;
- archive extraction rejects traversal/symlink escape and excessive expansion;
- parser limits prevent deep/large input exhaustion;
- error responses omit stack, secrets and internal identifiers;
- validation and authorization occur at authoritative server boundary;
- security tests cover malformed, duplicate, boundary and race cases;
- one dangerous feature is removed rather than filtered.

### Failure scenarios

1. SQL or shell string concatenation.
2. Path traversal through encoding/symlink/canonicalization gap.
3. Template or expression evaluation uses untrusted input.
4. Archive expands outside target or exhausts disk.
5. Validation occurs only in browser/client.
6. Error exposes credential, query or stack.
7. Check-then-use race changes authorized resource.

## Результат для базы знаний

- **Input validation, normalization and canonicalization**.
- **SQL, command, template and path injection prevention**.
- **Safe file and archive processing**.
- **Parser and resource limits**.
- **Security-oriented negative and fuzz testing**.

## Когда переходить дальше

Можно переходить, когда malformed and boundary inputs cannot escape intended data, command, file or resource scopes.