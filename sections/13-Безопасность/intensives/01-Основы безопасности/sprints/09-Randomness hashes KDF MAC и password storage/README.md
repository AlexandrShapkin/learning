# Спринт 09. Randomness, hashes, KDF, MAC и password storage

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Какие свойства дают randomness, hashing, key derivation and MAC, and where are they commonly misused?

## Результат спринта

После завершения необходимо уметь:

- use cryptographically secure random generation;
- distinguish hash, checksum, MAC and password KDF;
- understand preimage, second-preimage and collision properties;
- use salts and optional peppers correctly;
- select maintained password-hashing/KDF parameters;
- compare HMAC with plain hash for authenticity;
- avoid predictable tokens and truncated identifiers;
- rotate password/KDF parameters through rehash-on-login;
- use constant-time comparison where library requires;
- document key and parameter lifecycle.

## Основной маршрут

1. Generate session/reset/idempotency tokens with secure randomness.
2. Compare checksum, hash and HMAC behavior.
3. Store synthetic passwords with maintained KDF.
4. Increase cost parameters and migrate records.
5. Test token collision/predictability assumptions.

## Лабораторная работа

Создать `work/crypto-foundations/`.

### Requirements

- all security tokens use OS CSPRNG and sufficient entropy;
- password records include algorithm, parameters and salt;
- password verification supports parameter upgrade;
- HMAC key is separate from data/encryption keys;
- comparisons use maintained library functions;
- no password/security token is logged;
- benchmark balances resistance and service capacity;
- compromised database threat and optional pepper trade-off are documented.

### Failure scenarios

1. Time/PRNG-generated reset token is predictable.
2. Unsalted fast hash stores passwords.
3. Plain hash is used as message authenticator.
4. Same key is reused across unrelated purposes.
5. KDF cost causes login denial of service.
6. Token entropy is truncated by storage/schema.

## Результат для базы знаний

- **Cryptographic randomness and security tokens**.
- **Cryptographic hashes and collision properties**.
- **MAC and HMAC authenticity**.
- **Password KDFs, salts and parameter migration**.
- **Cryptographic key separation**.

## Когда переходить дальше

Можно переходить, когда tokens, passwords and authenticated data use appropriate primitives with measured parameters and explicit key separation.