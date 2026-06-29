# Спринт 02. Значения, типы и управление потоком

Ориентировочный объём: 12–17 часов.

## Центральный вопрос

Как язык представляет значения, ограничивает допустимые операции и управляет порядком вычислений?

## Результат спринта

После завершения необходимо уметь:

- различать value, variable, constant, type и representation;
- использовать integer, floating-point, boolean, string, rune и byte types осознанно;
- объяснять zero values и initialization;
- различать explicit conversion и implicit compatibility;
- понимать overflow, truncation, integer division и floating-point approximation;
- различать UTF-8 bytes, Unicode code points и user-perceived characters;
- применять `if`, `switch`, `for`, `range`, `break`, `continue` без скрытого control flow;
- выбирать type, отражающий domain constraints;
- использовать named types и constants для устранения invalid combinations;
- объяснять static/dynamic и strong/weak typing без рекламных ярлыков;
- читать basic type inference в Go;
- выявлять boundary cases через таблицы examples и tests.

## Основной маршрут

### Шаг 1. Values and variables

Изучить Go specification sections:

- declarations and scope overview;
- constants;
- variables and zero values;
- basic types;
- assignments.

### Шаг 2. Numeric semantics

Практически проверить:

- signed/unsigned ranges;
- overflow behavior;
- conversion narrowing;
- integer division/remainder;
- `math` functions;
- `NaN`, infinities and comparison;
- decimal money problem.

### Шаг 3. Strings and Unicode

Изучить:

- string as immutable bytes;
- UTF-8 encoding;
- `len`, indexing and `range`;
- `unicode/utf8` and `unicode` packages;
- invalid UTF-8 behavior.

### Шаг 4. Control flow

Сравнить imperative branching/loops с table-driven/data-driven подходом. Не заменять ясный `if` сложной abstraction.

## Ресурсы

### Обязательный маршрут

- A Tour of Go: basic types, flow control.
- Go specification: types, constants, variables, conversions.
- Go blog/article on strings, bytes, runes and characters.
- IEEE 754 overview through language/library docs.

### Альтернативные объяснения

- *The Go Programming Language*, basic data types and control flow.
- Python/JavaScript examples of dynamic coercion for comparison.

### Углубление

- arbitrary precision numbers;
- decimal floating point;
- Unicode grapheme clusters/normalization;
- refinement/dependent types;
- algebraic data types.

## Практические задания

### 1. Type boundaries

Написать tests/experiments для min/max values, overflow, conversion and division. Каждый result объяснить до запуска, затем сравнить.

### 2. Money model

Реализовать `Money` as integer minor units with currency code and checked operations. Запретить addition разных currencies. Сравнить с naive `float64` implementation.

### 3. Unicode inspection

CLI выводит для input string:

- byte length;
- rune count;
- each rune and byte offset;
- UTF-8 bytes;
- validity.

Проверить ASCII, Cyrillic, emoji, combining marks и invalid byte sequence.

### 4. Control-flow refactoring

Реализовать parser/classifier сначала nested branches, затем table-driven rules. Сравнить readability, testability and error messages; не считать меньший line count автоматически лучше.

## Лабораторная работа

Создать `work/datavalidator/` — валидатор typed records.

Input: JSON Lines with fields:

```text
id, timestamp, amount_minor, currency, status, description
```

### Требования

- parse JSON without silently converting large integers to imprecise float;
- use named types for ID, Currency, Status and Money;
- validate ranges and allowed transitions;
- distinguish missing, zero and invalid where format allows;
- report line number and field path;
- support text and JSON diagnostics;
- continue after invalid record with bounded error count;
- summary exit code: valid/invalid/input failure;
- table-driven tests for boundaries;
- fuzz seed cases for malformed UTF-8/JSON optional now, mandatory later;
- benchmark not required yet.

### Failure scenarios

1. Integer outside accepted range.
2. Unsupported currency.
3. Floating-point amount supplied instead of minor units.
4. Unknown status.
5. Invalid UTF-8 in description.
6. Truncated JSON line.
7. Very long line.
8. Duplicate ID in one input stream.

## Дополнительный эксперимент

Implement same coercion examples in Python and JavaScript/TypeScript. Record where runtime conversion occurs, where static checker helps and where runtime validation remains required.

## Самопроверка

1. Чем value отличается от variable?
2. Что даёт static type checking?
3. Что такое zero value?
4. Почему conversions may lose information?
5. Почему money через binary float problematic?
6. Чем byte, rune и character отличаются?
7. Почему `len(string)` не всегда число символов?
8. Что такое type inference?
9. Почему named type может предотвращать ошибки?
10. Когда control flow лучше table-driven logic?

Практическая проверка: по незнакомому expression определить result type/value/boundary behavior до запуска.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Value, variable and constant**.
- **Static and dynamic typing**.
- **Type conversion and coercion**.
- **Integer ranges and overflow**.
- **Floating-point representation**.
- **String, bytes, runes and UTF-8**.
- **Named types and domain constraints**.
- **Control flow** — branching, loops and data-driven alternatives.

## Когда переходить дальше

Можно переходить, когда validator preserves numeric precision, Unicode assumptions are tested, and domain-invalid combinations are rejected by types or explicit validation.