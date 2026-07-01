# Спринт 01. Сигналы, симптомы, ошибки и проверяемые гипотезы

Ориентировочный объём: 15–22 часа.

## Центральный вопрос

Как перейти от расплывчатого сообщения «система тормозит» к точному симптому, набору независимых сигналов и проверяемой гипотезе?

## Результат спринта

После завершения необходимо уметь:

- различать observation, signal, symptom, error, fault and failure;
- формулировать expected versus observed behavior;
- определять scope, onset, duration and affected population;
- отделять correlation from causality;
- строить dependency and request path;
- формулировать falsifiable hypotheses;
- выбирать discriminating observation;
- различать primary and downstream symptoms;
- искать first divergence rather than loudest alarm;
- использовать baseline and healthy comparison;
- учитывать missing/biased telemetry;
- документировать evidence and uncertainty.

## Основной маршрут

1. Take five vague reports and rewrite them as measurable symptoms.
2. Build a request/dependency path for the reference application.
3. For each symptom create at least three competing hypotheses.
4. Select one observation that differentiates each pair.
5. Reproduce a fault where the loudest downstream symptom is not the origin.

## Ресурсы

- Google SRE troubleshooting material.
- Brendan Gregg’s systems-performance methodology.
- selected hypothesis-driven debugging references.

## Лабораторная работа

Создать `work/diagnostic-foundations/`.

### Requirements

- symptom template contains user action, expected result, actual result, scope and time;
- dependency map includes application, database, network, storage and telemetry path;
- hypothesis log separates facts, assumptions and tests;
- every test predicts different outcomes for competing hypotheses;
- one healthy and one faulty run are compared;
- one misleading alert is traced to a shared upstream dependency;
- final report identifies first divergence and remaining uncertainty;
- no restart/config change is used before evidence capture.

### Failure scenarios

1. High CPU is called root cause without explaining workload or impact.
2. First dashboard anomaly is assumed causal.
3. Multiple variables are changed simultaneously.
4. Absence of logs is interpreted as absence of failure.
5. Healthy comparison uses different load/configuration.
6. Downstream timeout hides upstream queue saturation.
7. Investigation seeks confirmation only.
8. Timeline mixes observations and guesses.

## Самопроверка

1. Signal versus symptom?
2. Fault versus failure?
3. Correlation versus causality?
4. What makes a hypothesis falsifiable?
5. What is a discriminating test?
6. First divergence versus root cause?
7. Why compare with healthy baseline?
8. How can telemetry be biased?
9. Why preserve evidence before changes?
10. What uncertainty remains after diagnosis?

## Результат для базы знаний

- **Signals, symptoms, faults and failures**.
- **Hypothesis-driven technical diagnosis**.
- **First divergence and dependency paths**.
- **Healthy-state comparison and diagnostic baselines**.
- **Diagnostic evidence and uncertainty**.

## Когда переходить дальше

Можно переходить, когда a vague report becomes a bounded symptom and the leading explanation survives comparison against at least two competing hypotheses.