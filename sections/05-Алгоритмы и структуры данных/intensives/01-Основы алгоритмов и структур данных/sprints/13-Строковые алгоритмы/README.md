# Спринт 13. Строковые алгоритмы

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Как искать и сравнивать sequences efficiently while accounting for encoding, prefix structure, collisions and streaming input?

## Результат спринта

После завершения необходимо уметь:

- define byte/rune/code-point policy;
- implement naive substring search;
- understand prefix-function/KMP;
- implement Z-function or equivalent prefix matching;
- implement Rabin–Karp and collision verification;
- understand trie relation from sprint 08;
- use rolling hash cautiously;
- perform multi-pattern search overview through Aho–Corasick;
- understand edit distance via DP preview;
- distinguish exact from approximate matching;
- compare preprocessing/search costs;
- process streaming/chunk boundaries;
- handle empty pattern and overlapping matches;
- avoid Unicode-normalization assumptions;
- test against standard/reference search;
- choose stdlib search for production unless special requirement.

## Основной маршрут

### Шаг 1. Representation

Decide whether algorithm operates on bytes or runes. UTF-8 byte substring may differ from user-perceived text matching; normalization/case folding is separate.

### Шаг 2. Prefix algorithms

Study KMP prefix function and Z-function invariants. Trace fallback without rescanning text.

### Шаг 3. Hash-based matching

Rabin–Karp uses rolling hash as filter; equality must verify candidate unless collision policy explicitly probabilistic.

### Шаг 4. Multiple patterns

Build Aho–Corasick trie/failure links or implement reduced version. Understand output links and overlapping matches.

## Ресурсы

### Обязательный маршрут

- CLRS string matching.
- Sedgewick string algorithms.
- Go `strings`, `bytes`, Unicode docs.
- CP-Algorithms prefix/Z/Aho–Corasick as secondary reference.

### Углубление

- suffix arrays/trees;
- suffix automata;
- Burrows–Wheeler/FM-index;
- approximate matching;
- Unicode collation/normalization.

## Практические задания

1. Implement naive, KMP and Rabin–Karp with same match contract.
2. Implement prefix/Z arrays and verify identities on random strings.
3. Build multi-pattern matcher with failure transitions.
4. Add streaming matcher preserving state across chunks.
5. Compare byte and rune policies on multilingual text.

## Лабораторная работа

Создать `work/textlab/`.

### CLI

```text
textlab find --algorithm naive|kmp|rk PATTERN FILE
textlab multi PATTERNS FILE
textlab stream PATTERN FILE --chunk N
textlab inspect-prefix STRING
```

### Requirements

- empty-pattern semantics explicit;
- overlapping match positions returned;
- offsets documented as bytes or runes;
- differential tests against `bytes.Index`/simple oracle;
- fuzz algorithms for agreement;
- forced hash collisions in tests;
- chunk boundaries may split match/UTF-8 sequence according to policy;
- maximum pattern/input limits;
- benchmarks by alphabet, repetition and match frequency;
- no unverified hash-only equality for exact mode.

### Failure scenarios

1. Empty pattern infinite loop.
2. Overlapping matches skipped.
3. KMP fallback index wrong.
4. Rolling-hash subtraction/overflow mismatch.
5. Hash collision reported as match.
6. Chunk boundary loses partial match.
7. Byte/rune offsets mixed.
8. Invalid UTF-8 policy undefined.
9. Repetitive text degrades naive search.

## Самопроверка

1. Naive complexity?
2. What does prefix function represent?
3. Why KMP avoids rescanning?
4. What does rolling hash provide?
5. Why verify hash matches?
6. What does Aho–Corasick failure link do?
7. Byte versus rune matching?
8. How streaming matcher carries state?
9. What are overlapping matches?
10. When stdlib search is preferable?

## Результат для базы знаний

- **String representation for algorithms**.
- **Naive substring search**.
- **Prefix function and KMP**.
- **Z-function**.
- **Rabin–Karp and rolling hash**.
- **Aho–Corasick multi-pattern matching**.
- **Streaming string search**.
- **Unicode policy in text algorithms**.

## Когда переходить дальше

Можно переходить, когда algorithms agree under fuzzing, collision and chunk-boundary cases are tested, and offset/encoding policy is explicit.