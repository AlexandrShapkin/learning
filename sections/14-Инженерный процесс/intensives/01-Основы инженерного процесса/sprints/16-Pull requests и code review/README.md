# Спринт 16. Pull requests и code review

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как сделать review быстрым и содержательным, чтобы он снижал риск, распространял знания и не превращался в вкусовую проверку?

## Результат спринта

После завершения необходимо уметь:

- scope pull requests by one coherent change;
- provide problem, approach, risk and verification context;
- review correctness, design, security, operability and maintainability;
- distinguish blocking issues, questions and suggestions;
- use evidence and alternatives in comments;
- handle disagreement and decision ownership;
- reduce review latency and iteration count;
- avoid review theater and rubber stamps;
- use automation for mechanical checks;
- verify changes after revisions.

## Основной маршрут

1. Create one intentionally poor large PR.
2. Split or restructure it into focused PRs.
3. Conduct reviews from implementer, maintainer, quality and operations perspectives.
4. Resolve a technical disagreement with evidence.

## Лабораторная работа

Создать `work/code-review/`.

### Requirements

- PR explains problem, change, non-goals, risks and test evidence;
- diff excludes unrelated/generated noise where possible;
- reviewer verifies critical behavior rather than restating code;
- comments use severity/intention clearly;
- blocking feedback links to requirement, invariant or evidence;
- repeated style/mechanical issues move to automation;
- response resolves or records disagreement explicitly;
- final approval covers the latest revision;
- review wait/iteration causes are measured.

### Failure scenarios

1. PR contains several independent changes.
2. Description says only “please review”.
3. Review focuses on naming while missing correctness risk.
4. Every comment is treated as blocking.
5. Reviewer approves an outdated revision mentally.
6. Author resolves comments without changing/explaining.
7. Review queue depends on one unavailable expert.

## Результат для базы знаний

- **Focused pull requests**.
- **Code-review goals and perspectives**.
- **Blocking feedback, suggestions and questions**.
- **Review latency and iteration reduction**.

## Когда переходить дальше

Можно переходить, когда a reviewer can understand risk quickly, identify meaningful issues and approve the exact verified revision without unnecessary ceremony.