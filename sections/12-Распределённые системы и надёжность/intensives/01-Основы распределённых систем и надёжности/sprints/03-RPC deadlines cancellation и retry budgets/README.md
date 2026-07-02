# Спринт 03. RPC, deadlines, cancellation и retry budgets

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как ограничить ожидание удалённого вызова и повторять его так, чтобы не усиливать перегрузку и не дублировать необратимые эффекты?

## Результат спринта

После завершения необходимо уметь:

- различать connection, request and end-to-end deadlines;
- распространять cancellation through call chain;
- выделять timeout budget между dependencies;
- классифицировать retryable and non-retryable failures;
- применять exponential backoff and jitter;
- ограничивать attempts, elapsed time and concurrent retries;
- понимать ambiguous completion after timeout;
- проектировать idempotency for retried commands;
- различать retry at one layer and multiplicative retries;
- учитывать late responses and abandoned work;
- измерять retry amplification;
- выбирать fail-fast versus wait behavior.

## Основной маршрут

1. Implement API → service → provider call chain with contexts.
2. Introduce delay and lost responses.
3. Add nested retries and measure amplification.
4. Replace them with one explicit retry budget and idempotency key.

## Лабораторная работа

Создать `work/rpc-deadlines/`.

### Requirements

- end-to-end deadline is visible and propagated;
- child calls receive bounded remaining budget;
- cancellation stops abandoned work where possible;
- retry policy states errors, attempts, backoff, jitter and total budget;
- non-idempotent effect uses idempotency key or is not retried;
- late response cannot overwrite newer state;
- retry metrics distinguish logical operations and attempts;
- one overload test proves retries cannot multiply without bound;
- timeout reports preserve ambiguity when effect status is unknown.

### Failure scenarios

1. Every layer retries three times.
2. Timeout is longer than caller deadline.
3. Request is canceled but DB/provider work continues.
4. Lost response causes duplicate payment-like effect.
5. All clients retry simultaneously without jitter.
6. Old late response updates current result.
7. Connection timeout is confused with operation timeout.

## Результат для базы знаний

- **Distributed RPC deadlines and cancellation**.
- **Retry budgets, backoff and jitter**.
- **Ambiguous completion of remote operations**.
- **Retry amplification and layered retries**.
- **Idempotency requirements for retried commands**.

## Когда переходить дальше

Можно переходить, когда call-chain latency is bounded by one propagated budget and retries remain safe and capacity-limited under lost responses and overload.