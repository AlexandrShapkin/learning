# Спринт 14. Files, streams, encoding и serialization

Ориентировочный объём: 13–19 часов.

## Центральный вопрос

Как программа безопасно перемещает bytes между memory and external systems, преобразует их в text/records и сохраняет boundaries, errors and compatibility?

## Результат спринта

После завершения необходимо уметь:

- distinguish byte stream, record/message and structured data;
- use `io.Reader`, `io.Writer`, `io.Closer`, `io.Seeker` and composition patterns;
- explain buffering, flush and partial reads/writes;
- handle EOF correctly;
- distinguish binary data, text, encoding and Unicode normalization;
- use `bufio` without hidden token-size assumptions;
- work with files, temporary files and atomic replacement;
- serialize/deserialize JSON with explicit schema and validation;
- understand unknown/missing/zero fields and compatibility;
- compare JSON, XML, binary encoding and Protocol Buffers conceptually;
- avoid unbounded reads and memory amplification;
- design streaming decoder/encoder;
- preserve field/order/number semantics where required;
- diagnose truncation, corrupt framing, invalid encoding and flush/close errors;
- test I/O code through small interfaces and fault-injecting streams.

## Основной маршрут

### Шаг 1. I/O abstractions

Read Go `io`, `os`, `bufio`, `bytes`, `strings` docs. Study contracts:

- read may return `n > 0` with error;
- write may be partial;
- EOF is expected terminal condition;
- close/flush can fail;
- wrappers compose behavior.

### Шаг 2. Files and buffering

Practice open flags, permissions, offsets, buffered reader/writer, scanner limitations, temp files and rename.

### Шаг 3. Text and encoding

Review UTF-8 and Unicode from sprint 02. Add:

- newline conventions;
- BOM;
- malformed input policy;
- normalization overview;
- byte-oriented versus rune-oriented processing.

### Шаг 4. Serialization

Study `encoding/json`, `encoding/xml`, `encoding/binary` and protobuf overview. Treat serialization as an external contract, not automatic dump of internal structs.

## Ресурсы

### Обязательный маршрут

- Go `io`, `os`, `bufio`, `encoding/json` docs.
- JSON RFC 8259 selected sections.
- UTF-8 RFC 3629 and Unicode overview.
- Protocol Buffers language-neutral concepts.

### Альтернативные объяснения

- *The Go Programming Language* I/O chapters.
- TLPI file I/O chapters for OS boundary.

### Углубление

- zero-copy/splice/mmap;
- scatter/gather I/O;
- schema registries;
- canonical JSON;
- CBOR/MessagePack/Avro;
- compression streams;
- checksums and authenticated formats.

## Практические задания

### 1. Reader contract

Implement adversarial Reader returning small chunks, `n>0` plus error, delayed EOF and injected errors. Verify consumer handles all cases.

### 2. Partial writer

Create Writer that accepts only part of buffer or fails after N bytes. Use `io.Copy`/custom loops and explain behavior.

### 3. Streaming versus read-all

Process 1 GiB synthetic input through streaming and `ReadAll` versions under memory limit. Compare RSS/heap and failure behavior without committing data.

### 4. Schema evolution

Define JSON record v1/v2:

- add optional field;
- rename/deprecate field;
- unknown field policy;
- large integer preservation;
- timestamp format;
- enum validation.

Write compatibility tests.

## Лабораторная работа

Создать `work/streamcodec/` — streaming conversion tool.

```text
streamcodec convert --from jsonl --to framed-binary
streamcodec convert --from framed-binary --to jsonl
streamcodec inspect FILE
streamcodec validate FILE
```

### Binary frame

```text
magic | version | flags | payload length | payload | checksum
```

### Requirements

- bounded frame size;
- streaming input/output;
- exact handling of partial reads/writes;
- checksum verification;
- schema version and unknown-version rejection;
- JSON number precision preserved where required;
- text diagnostics include byte offset/record index;
- atomic output replacement;
- optional gzip wrapper through composition;
- tests with faulting readers/writers/closers;
- fuzz decoder with bounded frame length;
- benchmark throughput/allocation;
- no allocation proportional to entire file.

### Failure scenarios

1. Truncated header/payload.
2. Invalid magic/version.
3. Length exceeds limit.
4. Checksum mismatch.
5. Partial write/flush failure.
6. Invalid UTF-8/JSON.
7. Unknown field/schema compatibility.
8. Large integer loses precision.
9. Compression stream corrupt.
10. Output close/rename fails.

## Дополнительный эксперимент

Add Protocol Buffers implementation for same logical record and compare schema evolution, size, unknown fields and generated-code cost. Avoid claiming universal superiority.

## Самопроверка

1. What does Reader/Writer contract allow?
2. How should EOF be handled?
3. Why can close/flush fail?
4. What does buffering trade off?
5. Stream versus record?
6. Encoding versus serialization?
7. Why not expose internal struct as permanent wire format automatically?
8. How to bound memory for untrusted input?
9. What makes schema change compatible?
10. Why can JSON numbers be problematic?
11. What protects against truncation/corruption?

Практическая проверка: given corrupt file and decoder output, identify exact boundary/offset and whether failure is transport truncation, framing, checksum, encoding or schema.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **Byte stream and record framing**.
- **Go Reader and Writer contracts**.
- **Buffering and partial I/O**.
- **EOF and close errors**.
- **Text encoding and UTF-8 policy**.
- **Serialization schema and compatibility**.
- **JSON number and missing-field semantics**.
- **Streaming decoder design**.
- **Checksums and corruption detection**.

## Когда переходить дальше

Можно переходить, когда decoder survives truncation/fuzzing, conversion is bounded-memory, and schema/encoding failures are distinct and reproducible.