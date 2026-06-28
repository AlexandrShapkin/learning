# Спринт 04. Проверка основания

Ориентировочный объём: 5–8 часов.

Новая теория в этом спринте не вводится. Первая попытка выполняется без повторного чтения предыдущих материалов.

## Проверяемые спринты

- 01. Представление данных;
- 02. Логика и устройство компьютера;
- 03. Процессор и машинные инструкции.

## Часть 1. Теоретическая защита

Ответить своими словами и с одним конкретным примером на каждый вопрос:

1. Как биты получают значение и почему type является частью интерпретации?
2. Как two's complement позволяет одной схемой складывать signed и unsigned values?
3. Откуда берётся ошибка `0.1 + 0.2`?
4. Как из NAND получить memory state?
5. Как control signals ALU выбирают операцию?
6. Как instruction encoding связан с ISA?
7. Как calling convention связывает независимо скомпилированные функции?
8. Как source-level loop проявляется в registers, memory и control flow?
9. Какие этапы проходит instruction в упрощённом processor pipeline?
10. Что compiler может изменить, не нарушая observable behavior?

Ответ считается достаточным, если содержит механизм, а не только определение.

## Часть 2. Практическая задача: бинарный формат

Реализовать в `work/checkpoint/packet/` encoder и decoder следующего формата:

```text
offset  size  field
0       2     magic = 0xCAFE, big-endian
2       1     version = 1
3       1     flags
4       4     sequence, little-endian uint32
8       4     value, little-endian float32
12      2     payload length, big-endian uint16
14      N     UTF-8 payload
```

### Условия

- использовать Go;
- decoder не должен читать за границы buffer;
- проверить version, length и UTF-8;
- создать минимум восемь tests, включая truncation каждого многобайтового поля;
- вывести hex dump одного корректного packet;
- вручную подписать поля в dump до запуска decoder.

### Диагностическая неисправность

Создать второй decoder с одной намеренной ошибкой byte order для `sequence`. Тест должен обнаруживать ошибку на значении `0x01020304`. После демонстрации удалить defect или оставить его только в отдельном test fixture с пояснением.

## Часть 3. Практическая задача: машинный код

Использовать следующий файл:

```c
#include <stdint.h>

int transform(int x, uint8_t shift) {
    int y = x * 3 + 7;
    return (y >> shift) ^ 0x55;
}

int main(void) {
    return transform(-17, 2) & 0xff;
}
```

### Выполнение

1. До компиляции вычислить результат в модели C для своей platform.
2. Собрать `-O0` и `-O2` с debug symbols.
3. Найти multiplication, addition, shift и xor в assembly.
4. Установить, арифметический или логический shift использован.
5. Определить, осталась ли функция `transform` отдельным symbol при `-O2`.
6. В GDB остановиться перед `ret` и показать return register.
7. Объяснить отличие process exit status от полного integer return value `main`.

## Часть 4. Схема

Нарисовать одну схему пути:

```text
source expression
→ compiler representation
→ instruction bytes
→ instruction register / decoder
→ register operands
→ ALU
→ result register or memory
```

Для каждого перехода указать, какой контракт действует: language semantics, compiler, ISA, ABI или microarchitecture.

## Критерии прохождения

Проверка пройдена, если:

- packet tests проходят и corruption не принимается молча;
- hex dump размечается вручную;
- обе binary versions исследованы;
- shift и calling convention объяснены по disassembly;
- схема различает ISA, ABI и microarchitecture;
- минимум 8 из 10 теоретических вопросов отвечены без существенной ошибки.

При затруднении:

- byte order, overflow, UTF-8 → вернуться к спринту 01;
- ALU, state, datapath → к спринту 02;
- registers, assembly, call stack → к спринту 03.

## Результат для базы знаний

Новых заметок специально для checkpoint создавать не требуется. Исправить только те заметки предыдущих спринтов, в которых проверка выявила неверную или неполную модель.