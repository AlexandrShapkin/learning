# Спринт 01. Цели безопасности, активы, угрозы и риск

Ориентировочный объём: 16–23 часа.

## Центральный вопрос

Что именно нужно защищать, от кого, с каким допустимым ущербом и за какую стоимость?

## Результат спринта

После завершения необходимо уметь:

- различать confidentiality, integrity, availability, authenticity, accountability and privacy;
- определять assets, owners, dependencies and business value;
- различать threat, vulnerability, exposure, likelihood and impact;
- формулировать risk scenarios rather than generic fears;
- выбирать preventive, detective and recovery controls;
- оценивать inherent and residual risk;
- документировать assumptions and risk acceptance;
- избегать security-by-checklist.

## Основной маршрут

1. Inventory assets and data of the reference system.
2. Define five realistic threat actors and capabilities.
3. Create at least twelve risk scenarios.
4. Rank risks and choose proportionate controls.
5. Record residual risk and owners.

## Лабораторная работа

Создать `work/security-risk/`.

### Requirements

- asset register includes owner, sensitivity, availability need and dependencies;
- threat actors have motive, access and capability assumptions;
- scenarios use asset + threat + weakness + consequence;
- likelihood and impact criteria are consistent;
- controls state prevention, detection or recovery purpose;
- residual risk and acceptance authority are explicit;
- one high-severity but low-exposure item is deprioritized with evidence;
- one low-technical-severity item is raised due business impact.

### Failure scenarios

1. Vulnerability score is treated as risk.
2. Every asset is marked critical.
3. Threat actor capabilities are unlimited.
4. Control has no owner or test.
5. Compliance requirement replaces threat analysis.
6. Residual risk is omitted after mitigation.

## Результат для базы знаний

- **Security objectives and properties**.
- **Assets, threats, vulnerabilities and exposure**.
- **Security risk scenarios**.
- **Inherent and residual risk**.
- **Preventive, detective and recovery controls**.

## Когда переходить дальше

Можно переходить, когда control priorities are traceable to specific assets, realistic threats and residual risk.