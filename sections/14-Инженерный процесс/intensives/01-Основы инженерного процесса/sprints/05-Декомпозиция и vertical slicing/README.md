# Спринт 05. Декомпозиция и vertical slicing

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как разбить крупное изменение на small end-to-end slices that deliver value, reduce risk or produce learning?

## Результат спринта

После завершения необходимо уметь:

- различать horizontal component tasks and vertical slices;
- slice by workflow, persona, rule, data subset or risk;
- preserve deployability and compatibility;
- identify enabling work without turning it into endless foundation;
- isolate high-risk assumptions early;
- define thin end-to-end walking skeleton;
- plan migration through expand/contract and toggles conceptually;
- avoid slicing by organizational boundaries only;
- recognize slices that are too coupled or too large.

## Основной маршрут

1. Take one 4–8 week synthetic feature.
2. Map user/system workflow and risks.
3. Create walking skeleton plus 6–10 vertical slices.
4. Compare against component-based decomposition.
5. Sequence by learning and dependency.

## Лабораторная работа

Создать `work/change-slicing/`.

### Requirements

- each slice has one observable result and acceptance evidence;
- first slice crosses interface, logic and storage minimally;
- high-risk integration/assumption is tested early;
- slices remain independently mergeable/deployable where possible;
- compatibility/migration steps are explicit;
- foundational tasks are tied to a near-term slice;
- dependencies are reduced by interfaces/stubs rather than hidden;
- largest slice is small enough for focused review and rollback.

### Failure scenarios

1. Work is split into frontend/backend/database phases with no usable increment.
2. Months of platform foundation precede first feedback.
3. Slice requires all teams to finish simultaneously.
4. Migration is one irreversible cutover.
5. Toggle accumulates with no removal condition.
6. “Small” task still spans many unrelated risks.

## Результат для базы знаний

- **Vertical slicing of software changes**.
- **Walking skeleton and incremental delivery**.
- **Risk- and learning-based decomposition**.
- **Enabling work and migration sequencing**.

## Когда переходить дальше

Можно переходить, когда the first few slices can independently validate value or risk and no long component phase blocks end-to-end feedback.