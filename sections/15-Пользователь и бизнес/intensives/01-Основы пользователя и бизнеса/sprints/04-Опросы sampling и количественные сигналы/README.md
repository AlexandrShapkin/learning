# Спринт 04. Опросы, sampling и количественные сигналы

Ориентировочный объём: 18–27 часов.

## Центральный вопрос

Когда survey or quantitative sample can answer the question, and how avoid biased questions and false precision?

## Результат спринта

После завершения необходимо уметь:

- distinguish census, sample and convenience sample;
- define target population and sampling frame;
- write neutral, single-purpose questions;
- choose response scales and answer options;
- avoid double-barreled, leading and loaded questions;
- handle nonresponse and survivorship bias;
- summarize proportions and uncertainty;
- segment responses without overfitting;
- combine surveys with behavioral evidence;
- recognize when a survey cannot answer causality or unmet needs.

## Основной маршрут

1. Draft a survey from research questions.
2. Review and pilot it against synthetic respondents.
3. Generate biased and representative samples.
4. Compare conclusions and uncertainty.

## Лабораторная работа

Создать `work/surveys/`.

### Requirements

- target population and sampling frame are explicit;
- every question has one analytic purpose;
- response options include relevant neutral/unknown states;
- order and wording effects are considered;
- completion burden is bounded;
- nonresponse and exclusion are reported;
- estimates use counts, proportions and uncertainty rather than unsupported decimals;
- segmentation is predeclared or labeled exploratory;
- survey conclusions are triangulated with behavior/qualitative evidence.

### Failure scenarios

1. Survey is sent only to active satisfied users.
2. Question combines speed and ease in one answer.
3. Agreement scale encourages acquiescence.
4. Small subgroup percentage is reported as precise truth.
5. Missing responses are silently treated as negative or positive.
6. Stated preference is interpreted as actual purchase/adoption.

## Результат для базы знаний

- **Survey design and question bias**.
- **Sampling frames, convenience samples and nonresponse**.
- **Survey scales and response options**.
- **Quantitative uncertainty and exploratory segmentation**.

## Когда переходить дальше

Можно переходить, когда survey conclusions remain valid after sample, wording and missing-response limitations are exposed.